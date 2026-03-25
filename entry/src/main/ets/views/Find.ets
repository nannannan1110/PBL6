import { getSongList } from '../apis';
import { SongItemType } from '../models';
import { router } from '@kit.ArkUI';

@Component
export default struct Find {
  @State songs: SongItemType[] = [];
  router = this.getUIContext().getRouter();

  async aboutToAppear() {
    try {
      this.songs = await getSongList() as SongItemType[];
    } catch (error) {
      console.error('获取歌曲失败', JSON.stringify(error));
    }
  }

  build() {
    Column() {
      Text('猜你喜欢')
        .fontColor('#fff')
        .fontSize(18)
        .fontWeight(700)
        .width('100%')
        .margin({ top: 10, bottom: 15 })

      List() {
        ForEach(this.songs, (item: SongItemType) => {
          ListItem() {
            Row({ space: 10 }) {
              Image(item.img)
                .width(80)
                .aspectRatio(1)
                .borderRadius(8)

              Column({ space: 6 }) {
                Text(item.title)
                  .fontColor('#fff')
                  .fontWeight(700)
                  .width('100%')

                Row({ space: 8 }) {
                  Text('VIP')
                    .fontSize(12)
                    .fontColor('#bab128')
                    .border({ width: 1, color: '#bab128', radius: 12 })
                    .padding({ left: 5, right: 5, top: 2, bottom: 2 })
                  Text(item.artist)
                    .fontColor('#808082')
                    .fontSize(14)
                }
              }
              .layoutWeight(1)

              Image($r('app.media.ic_more'))
                .width(24)
                .fillColor('#fff')
            }
            .width('100%')
            .margin({ bottom: 12 })
            .onClick(() => {
              this.router.pushUrl({
                url: 'pages/Play',
                params: {
                  song: item,
                  playList: this.songs
                }
              });
            })
          }
        })
      }
      .width('100%')
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#1a1a18')
    .padding(8)
  }
}