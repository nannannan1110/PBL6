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

export interface SongItemType {
  img:string;  // 封面图
  title:string;  // 歌曲名称
  artist:string;  // 艺术家
  url:string;     // 歌曲URL
  id: string;     // 唯一标识
}