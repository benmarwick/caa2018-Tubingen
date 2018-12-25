
the easy topics seem to me to be: 
- [ ] respond to Heather and Jeremy with something about R as a case study for scripting languages in general
- [ ] Angus says to clarify our position, 
- [ ] Jeremy wants more on rrtools and why it's needed


Things to add
-[x] "boundary work" by Gyrien at the beginning of the paper 
-[x] other tool-driven changes in archaeoology: GIS, isotopes, remote sensing, DNA, networks

Yes! That topic of boundary work by Gieryn that you mention is perfect! What a good find! I believe it may also related to Galison's concept of 'trading zones'. Perhaps we could say something like the increasing use and availability of code, and demands for it by readers and peer reviews is active boundary work that is shifting the boundary of scientific and non-scientific archaeology. And we can follow up with some observation about how archaeologists are increasing found in trading zones with computer scientists and software engineers as they try to find effective and efficient methods to use code and made it available in research compendia. Yes, I think that paper on boundary work is very suitable for our paper!  I will work it into the intro section, and again to wrap up at the end. Thanks again for the tip!

#-----------------
Our paper for the JCAA:

I've read an article about "boundary work" by Gyrien (attached - it seemed to be quite widely cited) and it seems to discuss how we differentiate "science" from "non-science" and that there are not just theoretical aspects of this discussion ("reasoning and observation" by  Comte; "falsifiability" by Popper, ...), but a practical aspect: Scientists decide on a daily basis, what they consider to be scientific. This process of demarcation is something we actually try to do as well: We say, only papers that also submit code and data are scientific. 
Yeah, and then the paper goes on about different sociological theories of ideology and what ideologies of science have been developed. It concludes that the boundaries of science are ambigious and defined for specific goals of authority expansion, monopolization and protection of autonomy.

Sounds like something we can add to the beginning of our paper, where we talk about our aims.

#-----------------

You already mention C14-dating, I thought of GIS, networks, ABMs, isotope analysis, remote sensing and DNA analysis.
So how did the spatial turn happen? Emma Blake writes in "A Companion to Social Archaeology" (ed. by Meskell and Preucel) that it is based on work by Lefebvre and Foucoults (p. 234 - on google books) - which is theories I guess. I'm not sure how directly this relates to GIS (which would be the tool). GIS may have engaged more people with spatial issues than before, but surely maps and questions of distribution and landscapes have been around before, just analogue? At least in Germany I know several works that managed spatial questions without GIS. 
The popularity of social network analysis is, I think, quite substantially influenced by our new "networking-media" like facebook, twitter etc. Early non-archaeological applications date to the 1930s, but it took off in the 1990s with the development of software applications (says wikipedia). So here we also have a change that was influenced both by theory and tools.

ABMs have in a very simple form also been developed in the 1940s and have taken off in the 90s. Theoretical foundation is (says wikipedia) hart to track down and seems to stem from 1991 ( Holland, J.H.; Miller, J.H. (1991). "Artificial Adaptive Agents in Economic Theory" (PDF). American Economic Review. 81 (2): 365–71. Archived from the original (PDF) on 2005-10-27. ) The taking off of course is due to software development. In archaeology it seems, in my opinion, to be much tool-driven as well. Though maybe it is linked to the agency-discussion of the post-processualists?
Now, remote sensing, isotope analysis and DNA-analysis are very much tool-driven I think. They are very much rooted in the discipline they originate from and theory is more or less about how we ask questions with these tools and how we interprete the results. But without the tools it is quite hard to answer the questions or - as in C14-dating - it would have been done with a very very different approach (archaeologically - typologically).

But what now is the difference between those approaches and our "code!"-approach?

I believe the most important point is:
- coding is a universal method not linked to certain research questions 
- which might make it more a revolution not a turn -> can we do this? differentiate revolution from turn by applicability to amount of research questions?

Uhm. What do you think?

#---------------------------------------------------------
How many papers about LIDAR?
lidar <- 
archy_all_years %>% 
  filter(str_detect(tolower(TI), 'lidar'))
  # 57 articles

lidar_proportion_per_year <- 
  archy_all_years %>% 
  mutate(lidar = ifelse(str_detect(tolower(TI), 'lidar'),1,0)) %>% 
  group_by(PY)  %>% 
  summarise(lidar_n = sum(lidar), 
            all_articles = n()) %>% 
  mutate(prop_lidar = lidar_n / all_articles)
# 57 articles

ggplot(lidar,
       aes(PY)) +
  geom_histogram() +
  scale_y_continuous(labels = scales::comma) +
  theme_minimal(base_size = 18) +
  ggtitle(paste0("LIDAR papers (n = ", nrow(lidar), ") in ", prettyNum(nrow(archy_all_years), ",")," archaeology articles published 2007-2017"))

ggplot(lidar_proportion_per_year,
       aes(PY, prop_lidar)) +
  geom_col() +
  scale_y_continuous(name = "Proportion of all articles published each year") +
  xlab("Publication year") +
  theme_minimal(base_size = 18) +
  ggtitle(paste0("LIDAR papers (n = ", nrow(lidar), ") among ", prettyNum(nrow(archy_all_years), ",")," archaeology articles published 2007-2017"))
``


          