// 每日推荐类型
export interface DailyRecommendType {
  img: string;
  title: string;
  type: string;
  top: string;
  bottom: string;
}

// 推荐歌单类型
export interface RecommendListType {
  img: string;
  title: string;
  count: string;
}

// 底部导航 Tab 类型（修复报错专用）
export interface TabType {
  icon: Resource;
  text: string;
  name: string;
}