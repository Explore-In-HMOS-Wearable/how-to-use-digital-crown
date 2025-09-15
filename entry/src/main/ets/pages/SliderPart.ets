@Component
export struct SliderPart {
  @State sliderValue: number = 0;
  private crownAccumulator: number = 0

  build() {
    Column() {
      Slider({
        value: this.sliderValue,
        style: SliderStyle.InSet,
        direction: Axis.Vertical,
        reverse: true
      })
        .showTips(true)
        .trackColor(Color.Grey)
        .height('70%')
        .blockColor(Color.Orange)
        .selectedColor(Color.Orange)
        .onChange((value: number, mode: SliderChangeMode) => {
          this.sliderValue = value;
        })
    }
    .focusable(true)
    .focusOnTouch(true)
    .defaultFocus(true)
    .height('100%')
    .width('100%')
    .justifyContent(FlexAlign.Center)
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [[$r('app.color.base_background_gradient_start'), 0.0],
        [$r('app.color.base_background_gradient_end'), 1],]
    })
    .onDigitalCrown((event: CrownEvent) => {
      event.stopPropagation()


      this.crownAccumulator += event.degree * -1

      const step = Math.floor(this.crownAccumulator / 3)

      if (step !== 0) {
        let newValue = (this.sliderValue * 100) + step
        newValue = Math.min(100, Math.max(0, newValue))

        this.sliderValue = newValue / 100

        this.crownAccumulator = this.crownAccumulator % 3
      }
    })
  }
}