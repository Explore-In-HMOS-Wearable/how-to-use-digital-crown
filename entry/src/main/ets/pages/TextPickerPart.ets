@Component
export struct TextPickerPart {
  @State select: number = 1
  private fruits: string[] = ['apple1', 'orange2', 'peach3', 'grape4']
  private crownAccumulator: number = 0

  build() {
    Column() {
      TextPicker({ range: this.fruits, selected: this.select })
        .onChange((value: string | string[], index: number | number[]) => {
          console.info('Picker item changed, value: ' + value + ', index: ' + index)
        })
        .onScrollStop((value: string | string[], index: number | number[]) => {
          console.info('Picker scroll stopped, value: ' + value + ', index: ' + index)
        })
        .disappearTextStyle({ color: Color.Red, font: { size: 12, weight: FontWeight.Lighter } })
        .textStyle({ color: Color.White, font: { size: 16, weight: FontWeight.Normal } })
        .selectedTextStyle({ color: Color.Orange, font: { size: 20, weight: FontWeight.Bold } })
        .gradientHeight(100)
        .backgroundColor(Color.Transparent)
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [[$r('app.color.base_background_gradient_start'), 0.0],
        [$r('app.color.base_background_gradient_end'), 1],]
    })
    .focusable(true)
    .focusOnTouch(true)
    .defaultFocus(true)
    .onDigitalCrown((event: CrownEvent) => {
      event.stopPropagation()

      // Accumulate crown rotation
      this.crownAccumulator += event.degree

      // Define how sensitive the crown should be (smaller = more sensitive)
      const stepThreshold = 3
      const step = Math.floor(this.crownAccumulator / stepThreshold)

      if (step !== 0) {
        // Update the selected index
        let newIndex = this.select + step
        newIndex = Math.max(0, Math.min(this.fruits.length - 1, newIndex))

        this.select = newIndex

        // Reset accumulator remainder
        this.crownAccumulator = this.crownAccumulator % stepThreshold

        console.log('Selected by crown: ' + this.fruits[this.select])
      }
    })
  }
}