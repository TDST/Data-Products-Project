##################################################
#
# Shiny server app
#
# The server app receives the value for the number of closing index values to
# use in total, and a window that specifies the number of values to use
# when calculating a forecast of the trend of the market. It uses a data file containing
# daily closing values from Dow Jones index, sampled from the date range
# December 31st, 1999 to October 21st, 2014.
#
# Files:	DJA.csv
#
# Inputs:	end_point, forecast
# Outputs:	plot1, plot2, plot3
#
##################################################



library( shiny )
library( forecast )

# Define server logic for forecasting application
shinyServer(function(input, output) {

	# Calculate the forecast using the Average method, and generate a plot based on the specified
	# time interval

	output$plot1 <- renderPlot({

		end_point <- input$end_point
		forecast_period <- input$forecast
		dj <- read.csv( file="DJA.csv", colClasses=c( "character","numeric" ), sep=",", header = TRUE )
		dj <- ts( dj$DJIA )
		dj2 <- window( dj, end=end_point )
		plot( dj2, main="Dow Jones Index (Daily Closing: 1999-12-31--2014-10-21)", ylab="Closing", xlab="Day", xlim=c( 2,end_point+140 ) )
		lines( meanf( dj2, h=forecast_period )$mean, col="blue", lw=5 )
		legend( "topleft", lw=3, col=c( "blue" ), legend=c( "Mean method" ) )
	})

	# Calculate the forecast using the Naive method, and generate a plot based on the specified
	# time interval

	output$plot2 <- renderPlot({

		end_point <- input$end_point
		forecast_period <- input$forecast
		dj <- read.csv( file="DJA.csv", colClasses=c( "character","numeric" ), sep=",", header = TRUE )
		dj <- ts( dj$DJIA )
		dj2 <- window( dj, end=end_point )
		plot( dj2, main="Dow Jones Index (Daily Closing: 1999-12-31--2014-10-21)", ylab="Closing", xlab="Day", xlim=c( 2,end_point+140 ) )
		lines( rwf( dj2,h=forecast_period )$mean, col="red", lw=5 )
		legend( "topleft", lw=3, col=c( "red" ), legend=c( "Naive method" ) )
	})

	# Calculate the forecast using the Drfit method, and generate a plot based on the specified
	# time interval

	output$plot3 <- renderPlot({

		end_point <- input$end_point
		forecast_period <- input$forecast

		dj <- read.csv( file="DJA.csv", colClasses=c( "character","numeric" ), sep=",", header = TRUE )
		dj <- ts( dj$DJIA )
		dj2 <- window( dj, end=end_point )

		plot( dj2, main="Dow Jones Index (Daily Closing: 1999-12-31--2014-10-21)", ylab="Closing", xlab="Day", xlim=c( 2,end_point+140 ) )
		lines( rwf( dj2, drift=TRUE, h=forecast_period )$mean, col="green", lw=5 )
		legend( "topleft", lw=3, col=c( "green" ), legend=c( "Drift method" ) )
	})

	output$documentation <- renderPrint({
		print( "To run the program, select the total number of closing values for the Dow Jones index, from the time period of December 31st, 1999 to October 21st, 2014. Next choose the number past-values to be used by the forecasting algorithm." )
	})
})

