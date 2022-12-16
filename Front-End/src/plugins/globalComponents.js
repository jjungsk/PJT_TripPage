import Badge from "../components/TemplateComponents/Badge";
import BaseAlert from "../components/TemplateComponents/BaseAlert";
import BaseButton from "../components/TemplateComponents/BaseButton";
import BaseCheckbox from "../components/TemplateComponents/BaseCheckbox";
import BaseDropdown from "../components/TemplateComponents/BaseDropdown";
import BaseInput from "../components/TemplateComponents/BaseInput";
import BasePagination from "../components/TemplateComponents/BasePagination";
import BaseProgress from "../components/TemplateComponents/BaseProgress";
import BaseRadio from "../components/TemplateComponents/BaseRadio";
import BaseSlider from "../components/TemplateComponents/BaseSlider";
import BaseSwitch from "../components/TemplateComponents/BaseSwitch";
import Card from "../components/TemplateComponents/Card";
import Icon from "../components/TemplateComponents/Icon";

export default {
  install(Vue) {
    Vue.component(Badge.name, Badge);
    Vue.component(BaseAlert.name, BaseAlert);
    Vue.component(BaseButton.name, BaseButton);
    Vue.component(BaseInput.name, BaseInput);
    Vue.component(BaseCheckbox.name, BaseCheckbox);
    Vue.component(BasePagination.name, BasePagination);
    Vue.component(BaseProgress.name, BaseProgress);
    Vue.component(BaseRadio.name, BaseRadio);
    Vue.component(BaseSlider.name, BaseSlider);
    Vue.component(BaseSwitch.name, BaseSwitch);
    Vue.component(Card.name, Card);
    Vue.component(Icon.name, Icon);
    Vue.component(BaseDropdown.name, BaseDropdown);
  },
};
