#install.packages("rvest")
#install.packages("stringr")

library(rvest)
library(stringr)

movie_url = "https://movie.naver.com/movie/bi/mi/pointWriteFormList.nhn?code=168058&type=after&page="

star_list = numeric()
reply_list = character()
date_list = character()

for(page_url in 1:10){
  url = paste(movie_url,page_url,sep="")
  content = read_html(url)
  
  node1 = html_nodes(content, ".star_score em")
  node2 = html_nodes(content, ".score_reple p")
  node3 = html_nodes(content, ".score_reple em:nth-child(2)")
  node4 = html_nodes(content, ".btn_area strong span")
  
  star = html_text(node1)
  reply = html_text(node2)
  date = gsub("\\.","-",html_text(node3))
  
  
  star_list = append(star_list, star)
  reply_list = append(reply_list, reply)
  date_list = append(date_list, date)

}

df = data.frame(date_list, reply_list, star_list)
