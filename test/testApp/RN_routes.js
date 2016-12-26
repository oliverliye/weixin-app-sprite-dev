import pages_index_index from "./pages/index/RN_index";
import action_item_index from "./action/item/RN_index";

export default {
    'pages_index_index': {
        navigationBarBackgroundColor: "#ffffff",
        navigationBarTextStyle: "black",
        navigationBarTitleText: "微信接口功能演示",
        backgroundColor: "#eeeeee",
        backgroundTextStyle: "light",
        enablePullDownRefresh: "false",
        path: "pages/index",
        component: pages_index_index
    },
    'action_item_index': {
        navigationBarBackgroundColor: "#888",
        navigationBarTextStyle: "black",
        navigationBarTitleText: "WeChat",
        backgroundColor: "#ffffff",
        backgroundTextStyle: "light",
        enablePullDownRefresh: "false",
        path: "action/item/",
        component: action_item_index
    },
    __home__: "pages_index_index"
}