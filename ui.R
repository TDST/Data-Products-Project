##################################################
#
# Shiny ui app
#
# The UI app lets the user specify a number of data points from the closing values of
# Down Jones index, from the time interval of December 31st, 1999 to October 21st, 2014.
# These values are passed to the server which calculates forecast based on three different
# forecasting algortihms. The UI app then displays the plots returned from the server.
#
# Files:        DJA.csv
#
# Inputs:       none
# Outputs:      plot1, plot2, plot3
#
##################################################


library( shiny )
library( forecast )

# Define UI for forecasting application 
shinyUI(
	pageWithSidebar(

		# Application title
		headerPanel( "Forecasting the Dow Jones Industrial Index" ),

		# Sidebar with controls to select the random distribution type
		# and number of observations to generate.
		sidebarPanel(
			sliderInput( "end_point", "Number of observations:", value = 240, min = 1, max = 3714 ),
			sliderInput( "forecast", "Past-data window size", value = 50, min = 1, max = 1000, step=1 )
		),

	# Show a tabset that allows the user to select the appropriate plots
	mainPanel(

		tabsetPanel(
			tabPanel( "Documentation", verbatimTextOutput( "documentation" ) ),
			tabPanel( "Average algorithm", plotOutput( "plot1" ) ), 
			tabPanel( "Naïve algortihm", plotOutput( "plot2" ) ), 
			tabPanel( "Drift algorithm", plotOutput( "plot3" ) ) 
		)
	)
))
