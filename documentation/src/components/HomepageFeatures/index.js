import clsx from 'clsx';
import Heading from '@theme/Heading';
import styles from './styles.module.css';

const FeatureList = [
  {
    title: 'Легко начать использовать',
    Svg: require('@site/static/img/picture_1.svg').default,
    description: (
      <>
        OneKanban это библиотека/расширение для платформы 1С, достаточно его установить
        и указать используемые статусы
      </>
    ),
  },
  {
    title: 'Простота настройки',
    Svg: require('@site/static/img/picture_2.svg').default,
    description: (
      <>
        Можно настроить используемые проекты с выбором цвета.
      </>
    ),
  },
  {
    title: "Быстрые отборы",
    Svg: require('@site/static/img/picture_5.svg').default,
    description: (
      <>
        Быстрые отборы позволяют установить отборы задач без перерисовки страницы
      </>
    ),
  },
  {
    title: "Drag'n drop",
    Svg: require('@site/static/img/picture_3.svg').default,
    description: (
      <>
        Перетаскиванием мышки можно изменить статус задачи
      </>
    ),
  },
  {
    title: "Фотография исполнителя",
    Svg: require('@site/static/img/picture_4.svg').default,
    description: (
      <>
        На карточках задач есть фотография исполнителя
      </>
    ),
  },
  {
    title: "HTML/CSS",
    Svg: require('@site/static/img/picture_6.svg').default,
    description: (
      <>
        OneKanban написан на чистом HTML/CSS/js, без использования фреймворков
      </>
    ),
  },
];

function Feature({Svg, title, description}) {
  return (
    <div className={clsx('col col--4')}>
      <div className="text--center">
        <Svg className={styles.featureSvg} role="img" />
      </div>
      <div className="text--center padding-horiz--md">
        <Heading as="h3">{title}</Heading>
        <p>{description}</p>
      </div>
    </div>
  );
}

export default function HomepageFeatures() {
  return (
    <section className={styles.features}>
      <div className="container">
        <div className="row">
          {FeatureList.map((props, idx) => (
            <Feature key={idx} {...props} />
          ))}
        </div>
      </div>
    </section>
  );
}
