import R_$wxas$_React from 'react';
import R_$wxas$_ReactNative from 'react-native';
import R_$wxas$_styles from './RN_index_styles';
import R_$wxas$_class from './RN_index_class';
import R_$wxas$_template from 'weixin-app-sprite';
import R_$wxas$_rnweui from 'rnweui';
R_$wxas$_component = R_$wxas$_rnweui.component

export default function(R_$wxas$_page) {

    R_$wxas$_varBindArray = [];

    for (R_$wxas$_key in R_$wxas$_page.state)

        R_$wxas$_varBindArray.push("var " + R_$wxas$_key + "=R_$wxas$_page['" + R_$wxas$_key + "'];");

    eval(R_$wxas$_varBindArray.join(''));

    return R_$wxas$_React.createElement(
        R_$wxas$_component.view, {

            __class: R_$wxas$_class
        },
        function() {

            return R_$wxas$_React.createElement(
                R_$wxas$_component.view, {
                    'class': 'userinfo',

                    __class: R_$wxas$_class
                },
                R_$wxas$_React.createElement(
                    R_$wxas$_component.text,
                    null,
                    'oddoddoddoddodd'
                )
            );
        }()
    );;
}