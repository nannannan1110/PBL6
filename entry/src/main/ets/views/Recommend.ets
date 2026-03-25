import { getSwiper, getDailyRecommend, getRecommendList } from '../apis';
import { DailyRecommendType, RecommendListType } from '../models';

@Component
export default struct Recommend {

  @Builder
  searchBuilder() {
    Row() {
      Row({ space: 5 }) {
        Image($r('app.media.ic_search'))
          .width(20)
          .fillColor('#7e7e7c')
        TextInput({ placeholder: '搜索歌曲' })
          .padding({ left: 3 })
          .placeholderColor('#7e7e7c')
          .layoutWeight(1)
          .backgroundColor(Color.Transparent)
        Image($r('app.media.ic_code'))
          .width(22)
          .fillColor('#7e7e7c')
      }
      .width('100%')
      .height(35)
      .backgroundColor('#2d2b29')
      .borderRadius(20)
      .padding({ left: 8, right: 8 })
    }
    .width('100%')
    .padding({ top: 15, bottom: 10, left: 8, right: 8 })
  }

  @State swiperList: string[] = [];
  @State dailyRecommend: DailyRecommendType[] = [];
  @State recommendList: RecommendListType[] = [];

  async aboutToAppear() {
    try {
      this.swiperList = await getSwiper() as string[];
      this.dailyRecommend = await getDailyRecommend() as DailyRecommendType[];
      this.recommendList = await getRecommendList() as RecommendListType[];
    } catch (error) {
      console.error('请求失败', JSON.stringify(error));
    }
  }

  @Builder
  swiperBuilder() {
    Swiper() {
      ForEach(this.swiperList, (item: string) => {
        Image(item)
          .width('100%')
          .aspectRatio(720 / 330)
          .borderRadius(8)
      })
    }
    .padding(8)
    .width('100%')
    .autoPlay(true)
  }

  @Builder
  titleBuilder(title: string) {
    Row() {
      Text(title)
        .fontColor('#fff')
        .fontWeight(700)
        .fontSize(16)
      Image($r('app.media.ic_more'))
        .width(22)
        .fillColor('#fff')
    }
    .width('100%')
    .padding(8)
    .justifyContent(FlexAlign.SpaceBetween)
  }

  @Builder
  dailyBuilder() {
    Column() {
      this.titleBuilder('每日推荐')
      Scroll() {
        Row({ space: 10 }) {
          ForEach(this.dailyRecommend, (item: DailyRecommendType) => {
            Column() {
              Text(item.type)
                .width('100%')
                .backgroundColor(item.top)
                .padding(8)
                .fontColor('#fff')
              Image(item.img)
                .width('100%')
                .aspectRatio(1)
              Text(item.title)
                .width('100%')
                .backgroundColor(item.bottom)
                .padding(8)
                .fontColor('#fff')
                .fontSize(14)
                .maxLines(2)
                .textOverflow({ overflow: TextOverflow.Ellipsis })
            }
            .width('45%')
            .borderRadius(8)
            .clip(true)
          })
        }
      }
      .padding(8)
      .scrollable(ScrollDirection.Horizontal)
      .scrollBar(BarState.Off)
      .edgeEffect(EdgeEffect.Spring)
    }
  }

  @Builder
  songBuilder() {
    Column() {
      this.titleBuilder('推荐歌单')
      Scroll() {
        Row({ space: 8 }) {
          ForEach(this.recommendList, (item: RecommendListType) => {
            Column({ space: 5 }) {
              Stack({ alignContent: Alignment.TopStart }) {
                Image(item.img)
                  .width('100%')
                  .aspectRatio(1)
                  .borderRadius(8)
                Text(item.count)
                  .margin(10)
                  .fontColor('#fff')
                  .fontWeight(800)
                  .fontSize(14)
                  .textShadow({ offsetX: 2, offsetY: 2, radius: 2, color: '#000' })
              }
              Text(item.title)
                .width('100%')
                .maxLines(2)
                .textOverflow({ overflow: TextOverflow.Ellipsis })
                .fontColor('#fff')
                .fontSize(14)
                .lineHeight(18)
            }
            .width('30%')
          })
        }
      }
      .padding(8)
      .scrollable(ScrollDirection.Horizontal)
      .scrollBar(BarState.Off)
      .edgeEffect(EdgeEffect.Spring)
    }
  }

  build() {
    Scroll() {
      Column() {
        this.searchBuilder()
        this.swiperBuilder()
        this.dailyBuilder()
        this.songBuilder()
      }
      .constraintSize({ minHeight: '100%' })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#1a1a18')
    .scrollable(ScrollDirection.Vertical)
    .edgeEffect(EdgeEffect.Spring)
  }
}