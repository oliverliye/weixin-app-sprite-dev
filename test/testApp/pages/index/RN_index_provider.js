import R_$wxas$_React from 'react';
import R_$wxas$_ReactNative from 'react-native';
import R_$wxas$_styles from './RN_index_styles';
import R_$wxas$_template from 'weixin-app-sprite';
import R_$wxas$_rnweui from 'rnweui';
R_$wxas$_component = R_$wxas$_rnweui.component

export default function(R_$wxas$_page) {

    R_$wxas$_varBindArray = [];

    for (R_$wxas$_key in R_$wxas$_page.state)

        R_$wxas$_varBindArray.push("var " + R_$wxas$_key + "=R_$wxas$_page['" + R_$wxas$_key + "'];");

    eval(R_$wxas$_varBindArray.join(''));

    return R_$wxas$_React.createElement(
        R_$wxas$_component.view,
        null,
        function() {

            return R_$wxas$_React.createElement(
                R_$wxas$_component.view, {
                    style: [R_$wxas$_styles.style0]
                },
                R_$wxas$_React.createElement(
                    R_$wxas$_component.text,
                    null,
                    ' ddddddddddddddddd '
                )
            );
        }(),
        R_$wxas$_React.createElement(R_$wxas$_component.button, {
            label: 'aaaa'
        }),
        function() {
            R_$wxas$_data = [1, 2, 3, 4];
            R_$wxas$_result = [];

            for (var R_$wxas$_index = 0; R_$wxas$_index < R_$wxas$_data.length; R_$wxas$_index++) {
                var item = R_$wxas$_data[index];
                var index = R_$wxas$_index;
                R_$wxas$_result.push(R_$wxas$_React.createElement(
                    R_$wxas$_component.view,
                    {key: R_$wxas$_index},
                    R_$wxas$_React.createElement(
                        R_$wxas$_component.text, {
                            style: [R_$wxas$_styles.style1]
                            
                        },
                        ' ',
                        item,
                        ' '
                    )
                ));
            }
            return R_$wxas$_result;
        }()
    );;
}