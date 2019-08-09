
# We did a 'Cited Reference Search' in WoS for title "R: A Language and Environment for Statistical Computing" and author = "R Core Team", which is the output from  `citation()`. This function first appeared in 2004 https://github.com/wch/r-source/commits/9a5c086855d2e8fb07f670e3315871b2de31a4fd/src/library/base/inst/CITATION
#
# Note that before 2012 the authors were "R Development Core Team", and then it was simplified to "R Core Team" https://github.com/wch/r-source/commit/9a5c086855d2e8fb07f670e3315871b2de31a4fd#diff-80bb8a8b133a6204e9642d76791927e2
#
# We select all to get 185,121 results, then refine...

# Results: 47,462
# (from Web of Science Core Collection)
# You searched for: CITED AUTHOR: ("R DEV COR TEAM" OR "R # CORE" OR "R CORE TEAM" OR "R DEVELOPMENT CORE TEAM")
# Refined by: WEB OF SCIENCE CATEGORIES: ( ECOLOGY OR ENVIRONMENTAL SCIENCES ) AND LANGUAGES: ( ENGLISH ) AND DOCUMENT TYPES: ( ARTICLE )
# Timespan: All years. Indexes: SCI-EXPANDED, SSCI, A&HCI, ESCI.

# Export... full record... tab-delimited Mac UTF-8
# 0. 1-500 x
# 1. 501-1000 x
# 2. 1001-1500 x
# 3. 1501-2000 x
# 4. 2001-2500 x
# 5. 2501-3000 x
# 6. 3001-3500 x
# 7. 3501-4000 x
# 8. 4001-4500 x
# 9. 4501-4747 x

# field tags
# TS= Topic
# TI= Title
# AU= Author [Index]
# AI= Author Identifiers
# GP= Group Author [Index]
# ED= Editor
# SO= Publication Name [Index]
# DO= DOI
# PY= Year Published
# AD= Address
# OG= Organization-Enhanced [Index]
# OO= Organization
# SG= Suborganization
# SA= Street Address
# CI= City
# PS= Province/State
# CU= Country/Region
# ZP= Zip/Postal Code
# FO= Funding Agency
# FG= Grant Number
# FT= Funding Text
# SU= Research Area
# WC= Web of Science Category
# IS= ISSN/ISBN
# UT= Accession Number
# PMID= PubMed ID

# ecology articles citing R
ecology_articles_citing_r_files <-
  list.files(here::here("/analysis/data/raw_data/post-review/ecology-articles-citing-R"),
             full.names = TRUE)

ecology_articles_citing_r <-
  map(ecology_articles_citing_r_files,
      ~readr::read_tsv(.x,
                       quote = "",
                       col_types = cols(.default = col_character()))) %>%
  bind_rows() %>%
  mutate(PY = as.numeric(PY)) %>%
  filter(PY <= 2019)


# limit to top journals
top_ecology_journals_for_cran_cites <-
  ecology_articles_citing_r %>%
  group_by(SO) %>%
  tally(sort = TRUE)

how_many_articles_in_top_journals_for_cran_cites <-
  sum(top_ecology_journals_for_cran_cites$n)

# this is a hand-collected spreadsheet of the total number 
# articles published in these journals. We get these from Web
# of Science 'publication name' search
top_journals_for_cran_cites_articles_per_year <-
  read_csv(str_glue('{here::here()}/analysis/data/raw_data/top_journals_for_cran_cites_articles_per_year.csv')) %>%
  select(-X1) %>%
  gather(variable, value, -year) %>%
  separate(variable,
           into = str_glue('X{1:4}'),
           by = "_") %>%
  select(year, X4, value) %>% 
  rename( "journalname" = "X4", 
          'PY' = "year")

# tally by year
cran_cites_all_areas_top_ecol_journals_by_year <-
  ecology_articles_citing_r %>%
  filter(SO %in% top_ecology_journals_for_cran_cites$SO[1:10]) %>%
  group_by(SO, PY) %>%
  tally(sort = TRUE) %>%
  mutate(journalname = str_remove_all(SO, " |-"),
         PY = as.integer(PY)) %>%
  left_join(top_journals_for_cran_cites_articles_per_year) %>%
  mutate(prop = n / value ) %>%
  filter(SO != 'JOURNAL OF STATISTICAL SOFTWARE') %>%
  ungroup()

articles_shown_in_plot <-
  cran_cites_all_areas_top_ecol_journals_by_year %>%
  filter(!is.na(prop)) %>%
  summarise(sum_n = sum(n)) %>%
  pull(sum_n)

# nice labels with n for plot
cran_cites_all_areas_top_ecol_journals_by_year <-
  cran_cites_all_areas_top_ecol_journals_by_year %>%
  group_by(SO) %>%
  summarise(total_n_articles = sum(n)) %>%
  mutate(SO_n = as.character(glue('{SO} (n = {total_n_articles})'))) %>%
  right_join(cran_cites_all_areas_top_ecol_journals_by_year,
             by = "SO")


############################################################

min_y <- 2007
max_y <- 2025
eco_citing_R_over_time <-
  ggplot(cran_cites_all_areas_top_ecol_journals_by_year,
         aes(PY,
             prop,
             colour = SO)) +
  geom_line(size = 2) +
  geom_text_repel(
    data = subset(cran_cites_all_areas_top_ecol_journals_by_year,
                  PY == max(PY)),
    aes(label = str_wrap(SO_n, 40)),
    size = 4,
    nudge_x = 0,
    hjust = 0,
    segment.color = NA,
    direction = "y"
  ) +
  scale_x_continuous(breaks = min_y:max_y,
                     labels = c(min_y:2017, rep("", length(2018:max_y))),
                     limits = c(min_y, max_y)) +
  scale_y_continuous(labels = scales::percent) +
  xlab("Publication year") +
  ylab("Percentage of articles in that journal in that year") +
  theme_minimal() +
  theme(legend.position="none",
        axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.5))
