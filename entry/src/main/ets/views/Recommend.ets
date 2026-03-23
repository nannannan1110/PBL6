import { getSwiper, getDailyRecommend } from '../apis';
import { DailyRecommendType } from '../models';

@Component
export default struct Recommend {
  @State swiperList: string[] = [];
  @State dailyRecommend: DailyRecommendType[] = []; // 新增每日推荐数据状态

  async aboutToAppear() {
    this.swiperList = await getSwiper() as string[];
    this.dailyRecommend = await getDailyRecommend() as DailyRecommendType[]; // 获取每日推荐数据
  }

  // 标题构建函数（复用）
  @Builder
  titleBuilder(title: string) {
    Row() {
      Text(title)
        .fontColor('#fff')
        .fontWeight(700)
        .fontSize(18)
      Image($r('app.media.ic_more'))
        .width(22)
        .fillColor('#fff')
    }
    .width('100%')
    .padding(8)
    .justifyContent(FlexAlign.SpaceBetween)
  }

  // 每日推荐区域构建函数
  @Builder
  dailyBuilder() {
    this.titleBuilder('每日推荐')
    Scroll() {
      Row({ space: 10 }) {
        ForEach(this.dailyRecommend, (item: DailyRecommendType) => {
          Column() {
            // 类型标签
            Text(item.type)
              .width('100%')
              .backgroundColor(item.top)
              .padding(8)
              .fontColor('#fff')
              .fontSize(12)

            // 封面图
            Image(item.img)
              .width('100%')
              .aspectRatio(1)

            // 标题
            Text(item.title)
              .width('100%')
              .backgroundColor(item.bottom)
              .padding(8)
              .fontColor('#fff')
              .fontSize(14)
              .maxLines(2)
              .textOverflow({ overflow: TextOverflow.Ellipsis })
              .lineHeight(18)
          }
          .width('40%')
          .borderRadius(8)
          .clip(true)
        })
      }
    }
    .width('100%')
    .padding(8)
    .height(220)
    .scrollable(ScrollDirection.Horizontal)
    .scrollBar(BarState.Off)
    .edgeEffect(EdgeEffect.Spring)
  }

  build() {
    Scroll() {
      Column() {
        this.searchBuilder()
        this.dailyBuilder() // 添加每日推荐区域
      }
      .constraintSize({ minHeight: '100%' })
    }
    .scrollable(ScrollDirection.Vertical)
    .edgeEffect(EdgeEffect.Spring)
    .width('100%')
    .height('100%')
  }

  searchBuilder() {
    throw new Error('Method not implemented.');
  }
}