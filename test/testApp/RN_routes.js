import tab_pages_index_index from "./pages/index/RN_index";
import action_item_index from "./action/item/RN_index";

export default {
    'tab_pages_index_index': {
        navigationBarBackgroundColor: "#ffffff",
        navigationBarTextStyle: "black",
        navigationBarTitleText: "微信接口功能演示",
        backgroundColor: "#eeeeee",
        backgroundTextStyle: "light",
        enablePullDownRefresh: "false",
        wxas_path: "pages/index",
        wxas_component: tab_pages_index_index,
        wxas_name: 'tab_pages_index_index'
    },
    'action_item_index': {
        navigationBarBackgroundColor: "#888",
        navigationBarTextStyle: "black",
        navigationBarTitleText: "WeChat",
        backgroundColor: "#ffffff",
        backgroundTextStyle: "light",
        enablePullDownRefresh: "false",
        wxas_component: action_item_index,
        wxas_name: 'action_item_index'
    },
    wxas_home: "tab_pages_index_index"
}