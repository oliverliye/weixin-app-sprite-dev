import R_$wxas$_React from 'react';
import R_$wxas$_ReactNative from 'react-native';
import R_$wxas$_wxssrn from 'wxssrn';
import R_$wxas$_rnweui from 'rnweui';

import R_$wxas$_styles from './RN_index_styles';
import R_$wxas$_class from './RN_index_class';

R_$wxas$_component = R_$wxas$_rnweui.component

export default function(R_$wxas$_page) {

    R_$wxas$_varBindArray = [];

    for (R_$wxas$_key in R_$wxas$_page.state)

        R_$wxas$_varBindArray.push("var " + R_$wxas$_key + "=R_$wxas$_page['" + R_$wxas$_key + "'];");

    eval(R_$wxas$_varBindArray.join(''));

    return R_$wxas$_React.createElement(
        R_$wxas$_component.view, {

            wxasClass: R_$wxas$_class
        },
        function() {

            return R_$wxas$_React.createElement(
                R_$wxas$_component.view, {

                    style: [R_$wxas$_styles.style0],
                    wxasClass: R_$wxas$_class
                },
                R_$wxas$_React.createElement(
                    R_$wxas$_component.text, {

                        wxasClass: R_$wxas$_class
                    },
                    'ddddddddddddddddd'
                )
            );
        }(),
        R_$wxas$_React.createElement(
            R_$wxas$_component.button, {
                bindtap: function() {
                    return R_$wxas$_page['tapButton'];
                }(),

                wxasClass: R_$wxas$_class
            },
            R_$wxas$_React.createElement(
                R_$wxas$_component.text, {

                    style: [R_$wxas$_styles.style1],
                    wxasClass: R_$wxas$_class
                },
                'ddddddddddd'
            )
        ),
        R_$wxas$_React.createElement(
            R_$wxas$_component.button, {
                bindtap: function() {
                    return R_$wxas$_page['tapRequestButton'];
                }(),

                wxasClass: R_$wxas$_class
            },
            R_$wxas$_React.createElement(
                R_$wxas$_component.text, {

                    style: [R_$wxas$_styles.style2],
                    wxasClass: R_$wxas$_class
                },
                'request'
            )
        ),
        R_$wxas$_React.createElement(
            R_$wxas$_component.view, {
                hover: 'true',
                hoverClass: 'hoveclass',
                style: [R_$wxas$_styles.style3, R_$wxas$_wxssrn.parseStyle('width:' + 400 + ';height:' + 200 + ';background-color:red;')],
                wxasClass: R_$wxas$_class
            },
            R_$wxas$_React.createElement(
                R_$wxas$_component.text, {

                    style: [R_$wxas$_styles.style4],
                    wxasClass: R_$wxas$_class
                },
                'sdfsdfdsfdsfds'
            )
        )
    );;
}