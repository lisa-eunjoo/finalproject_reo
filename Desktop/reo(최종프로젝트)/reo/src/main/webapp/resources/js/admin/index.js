var ageChartLabels = [];
var ageChartDatas = [];
var topPayChartDatas = [];
var dateCountChartLabels = [];
var dateCountChartDatas = [];

function rgbRandom() {
	var r = 0, g = 0, b = 0;
	while (r == g && g == b && r == b) {
		// r = Math.floor(Math.random() * (255 - 0 + 1)) + 0;
		// g = Math.floor(Math.random() * (255 - 0 + 1)) + 0;
		// b = Math.floor(Math.random() * (255 - 0 + 1)) + 0;
		r = Math.floor(Math.random() * (151)) + 50;
		g = Math.floor(Math.random() * (151)) + 50;
		b = Math.floor(Math.random() * (151)) + 50;
	}
	return "#" + r.toString(16) + g.toString(16) + b.toString(16);
}

function rgbRandom2() {
	return "#"
			+ (Math.floor(Math.random() * (16777215 - 55 - 3276800 + 1)) + 3276800)
					.toString(16);
}

function rgbRandom3(count) {
	var returnData = [];
	for (i = 0; i < count; i++) {
		returnData.push(rgbRandom2());
	}
	return returnData;
}

CanvasJS.addColorSet("topPayChartColor", [ rgbRandom2(), rgbRandom2(),
		rgbRandom2(), rgbRandom2(), rgbRandom2() ]);

var topPayChart = new CanvasJS.Chart("topPayChart", {
	backgroundColor : "#F8F8F8",
	colorSet : "topPayChartColor",
	animationEnabled : true,
	theme : "light1",
	title : {
		text : "결제 Top5",
		fontSize : 24,
		fontColor : "#333333"
	},
	axisY : {
		labelFontSize : 18,
		labelFontColor : "#333333",
		includeZero : false
	},
	axisX : {
		labelFontSize : 18,
		labelFontColor : "#333333"
	},
	data : [ {
		type : "column",
		yValueFormatString : "#,##0",
		dataPoints : topPayChartDatas
	} ]
});

var ageCharColor = [ "#C81E32", "#F05AA0", "#F08C5A", "#F0C85A", "#3CB7C8",
		"#8C46DC", "#BAE7AF", "#AFC4E7" ];
var ageShuffle = ageCharColor.sort(function() {
	return 0.5 - Math.random();
});

var ageChart = {
	labels : ageChartLabels,
	datasets : [ {
		label : "회원 연령대",
		backgroundColor : ageShuffle,
		borderAlign : "center",
		borderColor : "RGBA(255, 255, 255 , 1)",
		borderWidth : 1,
		data : ageChartDatas,
		hoverBorderWidth : 2,
		weight : 1
	} ]
}

function createAgeChart() {
	var agectx = document.getElementById("ageChart").getContext("2d");
	new Chart(agectx, {
		type : "pie",
		data : ageChart,
		options : {
			maintainAspectRatio : false,
			title : {
				display : true,
				text : "회원 연령대",
				fontSize : 24,
				fontColor : "#333333"
			},
			legend : {
				position : "right",
				labels : {
					boxWidth : 40,
					fontSize : 18,
					fontColor : "#333333"
				}
			},
			tooltips : {
				titleFontSize : 16,
				bodyFontSize : 16
			},
			plugins : {
				datalabels : {
					color : "#222222",
					textAlign : "center",
					font : {
						lineHeight : 1.6
					},
					formatter : function(value, ctx) {
						return value + "명"; // ctx.chart.data.labels[ctx.dataIndex]
					}
				}
			}
		}
	});
}

var dateCountChart = {
	labels : dateCountChartLabels,
	datasets : [ {
		label : "방문자수",
		borderColor : ageShuffle[ageShuffle.length - 1],
		pointBackgroundColor : ageShuffle[ageShuffle.length - 2],
		pointBorderColor : ageShuffle[ageShuffle.length - 2],
		borderWidth : 3,
		pointHoverRadius : 8,
		data : dateCountChartDatas,
		fill : false,
		lineTenstion : 0
	} ]
}

function createDateCountChart() {
	var datecountctx = document.getElementById("dateCountChart").getContext(
			"2d");
	new Chart(datecountctx, {
		type : "line",
		data : dateCountChart,
		options : {
			responsive : true,
			title : {
				display : true,
				text : '일별 방문자수',
				fontSize : 24,
				fontColor : "#333333"
			},
			legend : {
				labels : {
					fontSize : 18,
					fontColor : "#333333"
				}
			},
			tooltips : {
				mode : 'index',
				intersect : false,
				titleFontSize : 16,
				bodyFontSize : 16
			},
			hover : {
				mode : 'nearest',
				intersect : true
			},
			maintainAspectRatio : false,
			scales : {
				xAxes : [ {
					ticks : {}
				} ],
				yAxes : [ {
					ticks : {
						max : Math.max.apply(null, dateCountChartDatas) + 1,
					}
				} ]
			},
			plugins : {
				datalabels : {
					opacity : 0
				}
			}
		}
	});
}