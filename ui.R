#setwd("/Users/Victor/Documents/open-welfare2/")

library(leaflet)
welfare = read.csv("welfare_data.csv", header=TRUE)
shinyUI(fluidPage(
  titlePanel("台灣縣市福利政策相關資料"),
  
  sidebarLayout(position = "right", 
                sidebarPanel(
#                   selectInput("area", 
#                               label = "County", c("", "Taipei City",
#                                                   "New Taipei City",
#                                                   "Keelung City",
#                                                   "Taoyuan City",
#                                                   "Hsinchu County",
#                                                   "Hsinchu City",
#                                                   "Miaoli County",
#                                                   "Taichung City",
#                                                   "Changhua County",
#                                                   "Nantou County",
#                                                   "Yunlin County",
#                                                   "Chiayi County",
#                                                   "Chiayi City",
#                                                   "Tainan City",
#                                                   "Kaohsiung City",
#                                                   "Yilan County",
#                                                   "Hualien County",
#                                                   "Taitung County",
#                                                   "Pingtung County",
#                                                   "Kinmen County",
#                                                   "Penghu County",
#                                                   "Lienchiang County"), selected=""),
                  
                  radioButtons("category", 
                              label = "Select Relevant Metric:",
                              choices = levels(welfare$category)
                  ),
                  mainPanel(
                    br(),br(),
                    strong("Sources:"),br()
                    ,p(a("托育三支箭", href="http://cpaboom.blogspot.com/2015/10/151021.html"))
                    ,p(a("桃園人口增加", href="http://news.ltn.com.tw/news/life/breakingnews/1773063"))
                    ,p(a("hackpad福利資源整理", href="https://g0vus.hackpad.com/2016-Open-Welfare-G2jzonhwhq9"))
                    ,p(a("連江縣104家庭所得來源", href="http://statdb.dgbas.gov.tw/pxweb/Dialog/Saveshow.asp"))
                    ,p(a("台灣內政部：出生率", href="http://www.ris.gov.tw/zh_TW/346"))
                    ,p(a("福利百寶箱", href="http://1957.mohw.gov.tw/"))
                    ,p(a("中華民國統計資訊網", href="http://statdb.dgbas.gov.tw/pxweb/Dialog/varval.asp?ma=CS3201A1A&ti=&path=../database/CountyStatistics/&lang=9"))
                    ,p(a("台灣地區家庭收支調查", href="http://win.dgbas.gov.tw/fies/quick100.asp"))
                    ,p(a("社會經濟資料庫：人口數據", href="http://210.65.89.57/STAT/Web/Portal/STAT_PortalHome.aspx"))
                    ,p("Updated Nov 2016")
                    )

                ),
                                

                mainPanel(leafletOutput('map',height="600px"))
  )))



# library(leaflet)
# shinyUI(fluidPage(
#   titlePanel("台灣縣市福利政策"),
#   
#   sidebarLayout(position = "right", 
#                 sidebarPanel(
#                   selectInput("time", 
#                               label = "Choose a time period",
#                               choices = list("1", "2", "3")
#                   )
#                 ),
#                 
#                 mainPanel(leafletOutput('map'))
#   )))