@Component
export struct GaugePart {
  @State sliderValue: number = 0;
  private crownAccumulator: number = 0

  build() {
    Gauge({ value: this.sliderValue, min: 0, max: 1 }) {

    }
    .focusable(true)
    .focusOnTouch(true)
    .defaultFocus(true)
    .height('100%')
    .width('100%')
    .colors(Color.Orange)
    .width('100%')
    .height('100%')
    .indicator(null)
    .strokeWidth(20)
    .trackShadow({ radius: 3, offsetX: 3, offsetY: 3 })
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

        console.log('LAle: '+ this.sliderValue.toString())
      }
    })
  }
}