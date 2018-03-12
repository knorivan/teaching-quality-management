$(function() {
	
	$(".board .panel").css({
		"cursor" : "pointer"
	}).on("click", function () {
		var title = $(this).find("h4").text()
		var url = ''
		if (title == '评价') {
			url = 'evaluate.html'
		} else if (title == '提问') {
			url = 'questions.html'
		} else {
			url = 'assessment.html'
		}
		window.location.href = url
	})
	
})

$(function() {
  var ctx, data, myBarChart, option_bars;
  Chart.defaults.global.responsive = true;
	option_bars = {
	    scaleBeginAtZero: true,
	    scaleShowGridLines: true,
	    scaleGridLineColor: "rgba(0,0,0,.05)",
	    scaleGridLineWidth: 1,
	    scaleShowHorizontalLines: true,
	    scaleShowVerticalLines: false,
	    barShowStroke: false,
	    barStrokeWidth: 0,
	    barValueSpacing: 5,
	    barDatasetSpacing: 1,
	    legendTemplate: "<ul class=\"<%=name.toLowerCase()%>-legend\"><% for (var i=0; i<datasets.length; i++){%><li><span style=\"background-color:<%=datasets[i].fillColor%>\"></span><%if(datasets[i].label){%><%=datasets[i].label%><%}%></li><%}%></ul>"
	};
  data = {
    labels: ['评价', '问答', '成绩', '问卷'],
    datasets: [{
        label: "My First dataset",
        fillColor: "rgba(26, 188, 156,0.2)",
        strokeColor: "#1ABC9C",
        pointColor: "#1ABC9C",
        pointStrokeColor: "#fff",
        pointHighlightFill: "#fff",
        pointHighlightStroke: "#1ABC9C",
        data: [65, 59, 80, 81]
     }]
  };
  
  ctx = $('#radar-chart').get(0).getContext('2d');
  myBarChart = new Chart(ctx).Radar(data, option_bars);
});