library("tidyverse")

wdi_data<-read_csv("data/wdi_data.csv")

countries_and_continents<-read_csv("data/countries.csv") %>% 
  rename(country=name)

indicators <- read_csv("data/indicators.csv")

function(input, output, session){
  
  
  updateSelectInput(
    session, 
    "selected_continent",
    choices=unique(countries_and_continents$continent)
  )
  
  observeEvent(c(input$selected_continent),
               {
                 countries_in_continents<-countries_and_continents %>% 
                   filter(continent==input$selected_continent) %>% 
                   pull(country)
                 updateSelectInput(
                   session, 
                   "selected_country",
                   choices=unique(countries_in_continents)
                 )  
               })
  
  updateSelectInput(session,
                    "selected_indicator",
                    choices = setNames(indicators$indicator_code, indicators$indicator_name))
  
  output$wdi_indicator_chart<-renderPlot({
    print(input$update_chart)
    
    if(input$update_chart == 0){ # not provide graph until click
      return()
    }
    
    selected_indicator_name <- indicators %>%
      filter(indicator_code == isolate(input$selected_indicator)) %>%
      pull(indicator_name)
    
    wdi_data %>% 
      filter(country==isolate(input$selected_country)) %>% 
      filter(indicator == isolate(input$selected_indicator)) %>%
      filter(!is.na(value)) %>% 
      ggplot(aes(x=year, y=value))+
      geom_path(color="blue")+
      labs(
        title = paste("Individuals using the Internet (% of population)", "in", input$selected_country),
        subtitle = "Data source: WDI Package, see data/world-bank.R for details"
      )
  })
}