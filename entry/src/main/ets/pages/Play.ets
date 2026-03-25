import { SongItem, PlayState, SongItemType } from '../models';

interface PlayParams {
  song: SongItemType;
  playList: SongItemType[];
  playIndex?: number;
}

@Entry
@Component
struct Play {
  @State panelHeight: string = '0%';
  @State playState: PlayState = new PlayState();
  @State rotateAngle: number = 0;

  animatorResult = this.getUIContext().createAnimator({
    duration: 1000 * 15,
    easing: 'linear',
    delay: 0,
    fill: 'none',
    direction: 'normal',
    iterations: -1,
    begin: 0,
    end: 360
  });

  aboutToAppear() {
    const params = this.getUIContext().getRouter().getParams() as PlayParams;
    if (params) {
      this.playState.playList = params.playList || [];
      this.playState.playIndex = params.playIndex || 0;
      const song = params.song;

      if (song) {
        this.playState.img = song.img;
        this.playState.title = song.title;
        this.playState.artist = song.artist;
        this.playState.url = song.url;
      }
    }

    this.animatorResult.onFrame = (val: number) => {
      this.rotateAngle = val;
    };
    this.animatorResult.play();
  }

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Stack() {
        Image(this.playState.img)
          .width('100%')
          .height('100%')
          .blur(1000)

        Column() {
          Column() {
            Stack({ alignContent: Alignment.Top }) {
              Row() {
                Row() {
                  Image(this.playState.img)
                    .width('70%')
                    .borderRadius(400)
                }
                .backgroundImage($r('app.media.ic_cd'))
                .backgroundImageSize(ImageSize.Cover)
                .justifyContent(FlexAlign.Center)
                .width('100%')
                .borderRadius(400)
                .clip(true)
                .aspectRatio(1)
                .rotate({ angle: this.rotateAngle })
              }
              .margin({ top: 50 })
              .width('90%')
              .aspectRatio(1)
              .justifyContent(FlexAlign.Center)
              .padding(24)

              Image($r('app.media.ic_stylus'))
                .width(200)
                .aspectRatio(1)
                .rotate({
                  angle: this.playState.isPlay ? -45 : -55,
                  centerX: 100,
                  centerY: 30
                })
                .animation({ duration: 500 })
            }

            Stack() {
              Column({ space: 8 }) {
                Text(this.playState.title)
                  .fontSize(28)
                  .fontWeight(FontWeight.Bold)
                  .fontColor(Color.White)
                Text(this.playState.artist)
                  .fontSize(18)
                  .fontColor(Color.White)
              }
              .layoutWeight(1)
              .justifyContent(FlexAlign.Center)
            }
            .layoutWeight(1)

            Row() {
              Badge({ value: '99+', style: { badgeSize: 12, badgeColor: '#45CCCCCC', borderWidth: 0 } }) {
                Image($r('app.media.ic_like'))
                  .fillColor(Color.White)
                  .width(24)
              }
              Badge({ value: '10W', style: { badgeSize: 12, badgeColor: '#45cccccc', borderWidth: 0 } }) {
                Image($r('app.media.ic_comment_o'))
                  .fillColor(Color.White)
                  .width(18)
              }
              Badge({ value: 'hot', style: { badgeSize: 12, badgeColor: '#a8ff3131', borderWidth: 0 } }) {
                Image($r('app.media.ic_bells_o'))
                  .fillColor(Color.White)
                  .width(24)
              }
              Badge({ value: 'vip', style: { badgeSize: 12, badgeColor: '#b7efd371', borderWidth: 0 } }) {
                Image($r('app.media.ic_download_o'))
                  .fillColor(Color.White)
                  .width(24)
              }
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceAround)

            Column() {
              Row({ space: 4 }) {
                Text('00:00')
                  .fontSize(12)
                  .fontColor(Color.White)
                Slider({ value: 0, min: 0, max: 0 })
                  .layoutWeight(1)
                  .blockColor(Color.White)
                  .selectedColor(Color.White)
                  .trackColor('#ccc5c5c5')
                  .trackThickness(2)
                Text('00:00')
                  .fontSize(12)
                  .fontColor(Color.White)
              }
              .width('100%')
              .padding(24)

              Row() {
                if (this.playState.playMode === 'auto') {
                  Image($r('app.media.ic_auto'))
                    .fillColor(Color.White)
                    .width(30)
                    .onClick(() => {
                      this.playState.playMode = 'repeat';
                    })
                } else if (this.playState.playMode === 'repeat') {
                  Image($r('app.media.ic_repeat'))
                    .fillColor(Color.White)
                    .width(30)
                    .onClick(() => {
                      this.playState.playMode = 'random';
                    })
                } else {
                  Image($r('app.media.ic_random'))
                    .fillColor(Color.White)
                    .width(30)
                    .onClick(() => {
                      this.playState.playMode = 'auto';
                    })
                }

                Image($r('app.media.ic_prev'))
                  .fillColor(Color.White)
                  .width(30)
                  .onClick(() => {})

                Image(this.playState.isPlay ? $r('app.media.ic_paused') : $r('app.media.ic_play'))
                  .fillColor(Color.White)
                  .width(50)
                  .onClick(() => {
                    this.playState.isPlay = !this.playState.isPlay;
                  })

                Image($r('app.media.ic_next'))
                  .fillColor(Color.White)
                  .width(30)
                  .onClick(() => {})

                Image($r('app.media.ic_song_list'))
                  .fillColor(Color.White)
                  .width(30)
                  .onClick(() => {
                    this.panelHeight = '100%';
                  })
              }
              .width('100%')
              .padding({ bottom: 24 })
              .justifyContent(FlexAlign.SpaceAround)
            }
            .width('100%')
          }
          .layoutWeight(1)
          .width('100%')
        }
        .padding({ bottom: 20 })
      }
      .width('100%')
      .height('100%')
      .backgroundColor(Color.Transparent)

      Column() {
        Column()
          .width('100%')
          .layoutWeight(1)
          .onClick(() => {
            this.panelHeight = '0%';
          })

        Column() {
          Row() {
            Row() {
              Image($r('app.media.ic_play'))
                .width(20)
                .fillColor('#ff5186')
            }
            .width(50)
            .aspectRatio(1)
            .justifyContent(FlexAlign.Center)

            Row({ space: 8 }) {
              Text(`播放列表 (${this.playState.playList.length})`)
                .fontColor(Color.White)
                .fontSize(14)
            }
            .layoutWeight(1)

            Image($r('app.media.ic_close'))
              .fillColor('#ffa49a9a')
              .width(24)
              .height(24)
              .margin({ right: 16 })
              .onClick(() => {
                this.panelHeight = '0%';
              })
          }
          .width('100%')
          .backgroundColor('#ff353333')
          .padding(8)
          .border({ width: { bottom: 1 }, color: '#12ec5c87' })
          .borderRadius({ topLeft: 4, topRight: 4 })

          List() {
            ForEach(this.playState.playList, (item: SongItemType, index: number) => {
              ListItem() {
                Row() {
                  Row() {
                    Text((index + 1).toString())
                      .fontColor('#ffa49a9a')
                  }
                  .width(50)
                  .aspectRatio(1)
                  .justifyContent(FlexAlign.Center)

                  Row({ space: 10 }) {
                    Column() {
                      Text(item.title)
                        .fontSize(14)
                        .fontColor(this.playState.playIndex === index ? '#f04c7e' : '#ffa49a9a')
                      Text(item.artist)
                        .fontSize(12)
                        .fontColor(this.playState.playIndex === index ? '#f04c7e' : Color.Gray)
                    }
                    .layoutWeight(1)
                    .alignItems(HorizontalAlign.Start)
                  }
                  .layoutWeight(1)
                  .onClick(() => {})

                  Image($r('app.media.ic_more'))
                    .width(24)
                    .height(24)
                    .margin({ right: 16 })
                    .fillColor(Color.Gray)
                }
                .alignItems(VerticalAlign.Center)
              }
              .border({ width: { bottom: 1 }, color: '#12ec5c87' })
            })
          }
          .layoutWeight(1)
          .width('100%')
          .backgroundColor('#ff353333')
        }
        .height(400)
      }
      .height(this.panelHeight)
      .animation({ duration: 300 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#333')
  }

  @Builder
  deleteButton(index: number) {
    Text('删除')
      .width(50)
      .height('100%')
      .backgroundColor(Color.Red)
      .fontColor(Color.White)
      .textAlign(TextAlign.Center)
  }
}