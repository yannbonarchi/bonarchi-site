import rss from '@astrojs/rss';
import { getCollection } from 'astro:content';

export async function GET(context) {
  const posts = (
    await getCollection('writing', ({ data }) => !data.draft && data.lang === 'en')
  ).sort((a, b) => b.data.pubDate.valueOf() - a.data.pubDate.valueOf());

  return rss({
    title: 'Bonarchi SIMEU',
    description:
      'Notes on fintech, mobile money, core banking, and the road from engineering to leadership, written from Central Africa.',
    site: context.site,
    items: posts.map((post) => ({
      title: post.data.title,
      description: post.data.description,
      pubDate: post.data.pubDate,
      link: `/writing/${post.data.urlSlug}/`,
    })),
  });
}
