am5.ready(function() {

// Create root element
// https://www.amcharts.com/docs/v5/getting-started/#Root_element
var root = am5.Root.new("mainchartdiv");


// Set themes
// https://www.amcharts.com/docs/v5/concepts/themes/
root.setThemes([
  am5themes_Animated.new(root)
]);


// Create chart
// https://www.amcharts.com/docs/v5/charts/percent-charts/pie-chart/
var chart = root.container.children.push(am5percent.PieChart.new(root, {
  layout: root.verticalLayout
}));


// Create series
// https://www.amcharts.com/docs/v5/charts/percent-charts/pie-chart/#Series
var series = chart.series.push(am5percent.PieSeries.new(root, {
  valueField: "value",
  categoryField: "category"
}));

function generateDatas(count) {
    var data = [];
     $.ajax({
      type : "POST",            // HTTP method type(GET, POST) 형식이다.
          url : "/main/GetData.do",      // 컨트롤러에서 대기중인 URL 주소이다.
          async: false,
          success : function(res){ // 비동기통신의 성공일경우 success콜백으로 들어옵니다. 'res'는 응답받은 데이터이다.
              // 응답코드 > 0000
              for(var i = 0; i < res.resultList.length; i++) {
                var data2 = {};
                data2.category = res.resultList[i]['edu'];
                switch (data2.category) {
                case '10':
                  data2.category = '중졸';
                  break;
                case '20':
                  data2.category = '고졸';
                  break;
                case '30':
                  data2.category = '초대졸';
                  break;
                case '40':
                  data2.category = '대졸';
                  break;
                case '50':
                  data2.category = '석사';
                  break;                
              }
                data2.value = res.resultList[i]['userCount'];
                data.push(data2);
              }
          },
          error : function(XMLHttpRequest, textStatus, errorThrown){ // 비동기 통신이 실패할경우 error 콜백으로 들어옵니다.
              alert("통신 실패.")
          }
    })
    return data;
  }

// Set data  5종류로 분류할것
// https://www.amcharts.com/docs/v5/charts/percent-charts/pie-chart/#Setting_data
series.data.setAll(generateDatas(5));





// Play initial series animation
// https://www.amcharts.com/docs/v5/concepts/animations/#Animation_of_series
series.appear(1000, 100);

}); // end am5.ready()