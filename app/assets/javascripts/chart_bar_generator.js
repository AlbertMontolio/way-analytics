const chartBarGenerator = (dataX, dataY, idChart, type) => {
	var ctx = document.getElementById(idChart);
	// ctx.height = 100;
	// ctx.width = 100;
	var chart = new Chart(ctx, {
	    type: type,
	    data: {
	        labels: dataX,
	        datasets: [{
	            label: 'num. employees per division',
	            data: dataY,
	            backgroundColor: [
	                'rgba(255, 99, 132, 0.7)',
	                'rgba(54, 162, 235, 0.7)',
	                'rgba(255, 206, 86, 0.7)',
	                'rgba(75, 192, 192, 0.7)',
	                'rgba(153, 102, 255, 0.7)',
	                'rgba(255, 159, 64, 0.7)',
	                'rgba(255, 99, 132, 0.7)',
	                'rgba(54, 162, 235, 0.7)',
	                'rgba(255, 206, 86, 0.7)',
	                'rgba(75, 192, 192, 0.7)',
	                'rgba(153, 102, 255, 0.7)',
	                'rgba(255, 159, 64, 0.7)'
	            ],
	            borderColor: [
	                'rgba(255,99,132,1)',
	                'rgba(54, 162, 235, 1)',
	                'rgba(255, 206, 86, 1)',
	                'rgba(75, 192, 192, 1)',
	                'rgba(153, 102, 255, 1)',
	                'rgba(255, 159, 64, 1)',
	                'rgba(255,99,132,1)',
	                'rgba(54, 162, 235, 1)',
	                'rgba(255, 206, 86, 1)',
	                'rgba(75, 192, 192, 1)',
	                'rgba(153, 102, 255, 1)',
	                'rgba(255, 159, 64, 1)'
	            ],
	            borderWidth: 1
	        }]
	    },
	    options: {
	    	legend: {
	    		display: false,
	            labels: {
	                fontColor: "black",
	                // fontSize: 18
	            }
	        },
	        scales: {
	            yAxes: [{
	            	display: true,
	    	        gridLines: {
	    	          display: true,
	    	          color: "rgb(150,150,150)"
	    	        },
	                ticks: {
	                    beginAtZero:true,
	                    fontColor: "black"
	                }
	            }],
	            xAxes: [{
	            	display: true,
	    	        gridLines: {
	    	          display: false,
	    	          color: "black"
	    	        },
	                ticks: {
	                    // beginAtZero:true,
	                    fontColor: "black",
	                    autoSkip: false
	                }
	            }]
	        }
	    }
	});
}

