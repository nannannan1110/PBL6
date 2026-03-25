import { getSongList } from '../apis';
import { SongItemType } from '../models';

@Component
export default struct Find {
  // 保存请求数据
  @State songs: SongItemType[] = [];

  // 页面显示前请求数据
  async aboutToAppear() {
    try {
      this.songs = await getSongList() as SongItemType[];
    } catch (error) {
      console.error('获取歌曲列表失败', JSON.stringify(error));
    }
  }

  build() {
    Column() {
      // 标题
      Text('猜你喜欢')
        .fontColor('#fff')
        .fontSize(18)
        .fontWeight(700)
        .width('100%')
        .margin({ top: 10, bottom: 15 })

      // 歌曲列表
      List() {
        ForEach(this.songs, (item: SongItemType) => {
          ListItem() {
            Row({ space: 10 }) {
              // 封面图
              Image(item.img)
                .width(80)
                .aspectRatio(1)
                .borderRadius(8)

              // 标题 + 歌手
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

              // 更多按钮
              Image($r('app.media.ic_more'))
                .width(24)
                .fillColor('#fff')
            }
            .width('100%')
            .margin({ bottom: 12 })
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