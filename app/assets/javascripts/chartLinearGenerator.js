const linearChartGenerator = (firstYearsDays, monthlyAgesAverages) => {

  new Chart(document.getElementById("evolution_average_age"), {
    type: 'line',
    data: {
      labels: firstYearsDays,
      datasets: [{ 
          data: monthlyAgesAverages,
          label: "Africa",
          borderColor: "#3e95cd",
          fill: false
        },
      ]
    },
    options: {
      legend: {
        display: false,
        labels: {
            fontColor: "black",
            // fontSize: 18
        }
      },
    }
  });

}