archy_ctv_readme <- readLines("analysis/data/raw_data/ctv-archaeology-README.md")


top_archy_journals <-
str_subset(archy_ctv_readme, "Journal of Archaeological Method and Theory|J Archaeol Sci|Journal of Anthropological Archaeology|Journal of Archaeological Science")

archy_ctv_readme <- top_archy_journals

archy_ctv_readme <- collapse(archy_ctv_readme)
archy_ctv_readme <- str_remove_all(archy_ctv_readme, "[[:punct:]]")
archy_ctv_readme_20XX <- str_extract_all(archy_ctv_readme, " 20[[:digit:]]{2} ")
archy_ctv_readme_20XX <- str_squish(unlist(archy_ctv_readme_20XX))
archy_ctv_readme_20XX <- as.numeric(archy_ctv_readme_20XX)
archy_ctv_readme_20XX <- archy_ctv_readme_20XX[archy_ctv_readme_20XX > 2010]
length(archy_ctv_readme_20XX)
hist(archy_ctv_readme_20XX)
stem(archy_ctv_readme_20XX)
