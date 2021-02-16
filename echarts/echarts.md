# echarts模板

## 折线图

### vo

```java
package com.wistron.common.vo;

import java.util.Arrays;
import java.util.List;

/**
 * echartsVo类
 */
public class EchartsVo {

    /* 属性 */
    private String name;
    private String type = "line";
    private String stack = "总量";
    private String [] areaStyle = {};
    private List<Integer> data;

    /* get set 方法 */
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getStack() {
        return stack;
    }

    public void setStack(String stack) {
        this.stack = stack;
    }

    public String[] getAreaStyle() {
        return areaStyle;
    }

    public void setAreaStyle(String[] areaStyle) {
        this.areaStyle = areaStyle;
    }

    public List<Integer> getData() {
        return data;
    }

    public void setData(List<Integer> data) {
        this.data = data;
    }

    /* 构造函数 */
    public EchartsVo(){

    }

    public EchartsVo(String name, List<Integer> data) {
        this.name = name;
        this.data = data;
    }

    /* toString 方法 */
    @Override
    public String toString() {
        return "EchartsVo{" +
                "name='" + name + '\'' +
                ", type='" + type + '\'' +
                ", stack='" + stack + '\'' +
                ", areaStyle=" + Arrays.toString(areaStyle) +
                ", data=" + data +
                '}';
    }
}
```

### js

```js
				// 基于准备好的dom，初始化echarts实例
                var myChart = echarts.init(document.getElementById('echartsId'));

                // 指定图表的配置项和数据
                option = {
                    title: {
                        text: '2020 project status'
                    },
                    tooltip: {
                        trigger: 'axis',
                        axisPointer: {
                            type: 'cross',
                            label: {
                                backgroundColor: '#6a7985'
                            }
                        }
                    },
                    legend: {
                        data: ['Open', 'On-going', 'Close', 'Cancel', 'Sub Total', '本周新增', '本周完成']
                    },
                    toolbox: {
                        feature: {
                            saveAsImage: {}
                        }
                    },
                    grid: {
                        left: '3%',
                        right: '4%',
                        bottom: '3%',
                        containLabel: true
                    },
                    xAxis: [
                        {
                            type: 'category',
                            boundaryGap: false,
                            data: ['OA/Infra', 'ERP/WMS', 'CIM/MES', 'I4.0', 'New System Dev', 'System RollOut', 'Other']
                        }
                    ],
                    yAxis: [
                        {
                            type: 'value'
                        }
                    ],
                    // data.data.echartsVoList 为获取的数据
                    series: data.data.echartsVoList
                };

                console.log("echarts数据", data.data.echartsVoList);
                // 使用刚指定的配置项和数据显示图表。
                myChart.setOption(option);
```

