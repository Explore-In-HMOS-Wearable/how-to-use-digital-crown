import { ArcList, ArcListItem, ArcListAttribute, ArcListItemAttribute, ComponentContent } from '@kit.ArkUI';
import { NavigationService } from '../core/services/NavigationService';
import { GaugePart } from './GaugePart';
import { SliderPart } from './SliderPart';
import { TextPickerPart } from './TextPickerPart';

@Builder
export function MenuCard(title: string) {
  Column() {
    Text(title)
      .fontSize('14fp')
      .fontColor(Color.White)
      .margin({ top: 4, bottom: 4 })
  }
  .justifyContent(FlexAlign.Center)
  .alignItems(HorizontalAlign.Center)
  .width('90%')
  .borderRadius(8)
  .backgroundColor(Color.Brown)
}


@Entry
@Component
struct Index {
  context: UIContext = this.getUIContext();
  scroller: Scroller = new Scroller()

  @Builder
  routeMap(name: string) {
    NavDestination() {
      if (name === "SliderPart") {
        SliderPart()
      } else if (name === "GaugePart") {
        GaugePart()
      } else if (name === "TextPickerPart") {
        TextPickerPart()
      }
    }.hideTitleBar(true)
  }

  build() {
    Navigation(NavigationService.getInstance().pageInfos) {

      ArcList({
        initialIndex: 0,
        scroller: this.scroller,
      }) {

        ArcListItem() {
          MenuCard('SliderPart');
        }
        .width('95%')
        .margin({ bottom: 10 })
        .onClick(() => {
          NavigationService.getInstance().pageInfos.pushPath({ name: "SliderPart" })
        });

        ArcListItem() {
          MenuCard('GaugePart');
        }
        .width('95%')
        .margin({ bottom: 10 })
        .onClick(() => {
          NavigationService.getInstance().pageInfos.pushPath({ name: "GaugePart" })
        });

        ArcListItem() {
          MenuCard('TimePicker');
        }
        .width('95%')
        .margin({ bottom: 10 })
        .onClick(() => {
          NavigationService.getInstance().pageInfos.pushPath({ name: "TextPickerPart" })
        });

      }
      .borderRadius('466px')
      .focusable(true)
      .focusOnTouch(true)
      .defaultFocus(true)
      .height('100%')
      .width('100%')
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [[$r('app.color.base_background_gradient_start'), 0.0],
          [$r('app.color.base_background_gradient_end'), 1],]
      })
    }
    .navDestination(this.routeMap)
    .ignoreLayoutSafeArea()
    .hideTitleBar(true)
    .width('100%')
    .height('100%')
    .onDigitalCrown((event: CrownEvent) => {
      event.stopPropagation()
      const currentOffset = this.scroller.currentOffset().yOffset
      const newOffset = currentOffset - (event.degree * 3) // adjust scroll sensitivity
      this.scroller.scrollTo({ yOffset: newOffset, animation: false, xOffset: 0 })
    })

  }
}
