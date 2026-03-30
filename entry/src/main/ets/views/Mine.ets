import { getSongList } from '../apis';
import { SongItemType, SongItem } from '../models';

@Component
export default struct Mine {
  @State showList: SongItemType[][] = [[], [], [], []];
  columnList: number[] = [0, 1, 2, 3];

  async aboutToAppear() {
    try {
      const songList: SongItemType[] = await getSongList() as SongItemType[];
      if (!songList.length) return;

      // 随机打乱并分配到4列
      this.columnList.forEach((item) => {
        this.showList[item] = songList
          .map((s) => new SongItem(s))
          .sort(() => Math.random() - 0.5);
      });
    } catch (err) {
      console.error('获取歌曲失败', JSON.stringify(err));
    }
  }

  build() {
    Column() {
      // ==========================
      // 顶部：歌曲瀑布流背景（你要的4列网格）
      // ==========================
      Column() {
        // ========== 你指定加入的网格布局 ==========
        GridRow({
          // 关键1：设置断点与列数
          // breakpoints: { value: ['100vp'] }, // 仅1个断点，保证所有屏幕都是4列
          columns: 4, // 总列数固定为4
          gutter: { x: 2, y: 2 }            // 项之间的横向/纵向间距
        }) {
          // 遍历每列生成网格项
          ForEach(this.columnList, (item: number) => {
            GridCol({ span: 1}) { // 每个项占1列
              SongCard({ songs: this.showList[item] })  // 传递当前列的歌曲数据
            }
          })
        }
        // ==========================================
      }
      .scale({ x: 1.15, y: 1.15, centerX: '50%', centerY: '0' })
      .height('75%')
      .width('100%')
      .backgroundColor('#000')

      // ==========================
      // 底部：个人信息卡片
      // ==========================
      Column() {
        // 头像
        Column() {
          Image($r('app.media.logo'))
            .width('90%')
        }
        .backgroundColor(Color.Black)
        .width(80)
        .aspectRatio(1)
        .borderRadius(40)
        .offset({ y: -40 })

        // 信息区域
        Column({ space: 12 }) {
          // 昵称 + VIP
          Row({ space: 8 }) {
            Text('黑马云音乐')
              .fontColor(Color.White)
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
            Image($r('app.media.ic_vip'))
              .width(20)
          }

          // 标签
          Row() {
            Image($r('app.media.ic_boy'))
              .width(14)
              .fillColor('#23496b')
            Text(' 00后 · 双子座 · 北京 · 歌龄·2年')
              .fontColor('#777')
              .fontSize(14)
          }

          // 统计
          Row({ space: 16 }) {
            Text('1 关注')
              .fontColor('#777')
              .fontSize(14)
            Text('10万 粉丝')
              .fontColor('#777')
              .fontSize(14)
            Text('167万 赞')
              .fontColor('#777')
              .fontSize(14)
          }
        }
        .alignItems(HorizontalAlign.Center)
        .offset({ y: -20 })
      }
      .width('100%')
      .height('25%')
      .backgroundColor('#121215')
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#000')
  }
}

// ==========================
// 歌曲卡片（单列瀑布流）
// ==========================
@Component
struct SongCard {
  @Prop songs: SongItemType[] = [];

  build() {
    List({ space: 8 }) {
      ForEach(this.songs, (item: SongItemType) => {
        ListItem() {
          Image(item.img)
            .width('100%')
            .aspectRatio(1)
            .borderRadius(6)
            .clip(true)
        }
      })
    }
    .width('100%')
    .scrollBar(BarState.Off)
  }
}