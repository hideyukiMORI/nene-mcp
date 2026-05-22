import { defineConfig } from 'vitepress';

type NavLabels = {
  tutorial: string;
  howto: string;
  explanation: string;
  reference: string;
  integrations: string;
};

type SidebarLabels = {
  tutorialGroup: string;
  gettingStarted: string;
  cursorSetup: string;
  howtoGroup: string;
  integrateNene: string;
  otherPlatforms: string;
  writeTools: string;
  catalogSmoke: string;
  healthCatalog: string;
  neenePatterns: string;
  explGroup: string;
  scope: string;
  architecture: string;
  security: string;
  refGroup: string;
  envVars: string;
  mcpProtocol: string;
  catalogFormat: string;
  intGroup: string;
  ecosystem: string;
  contribGroup: string;
  fieldTrials: string;
  methodology: string;
};

function nav(t: NavLabels, p: string = '') {
  return [
    { text: t.tutorial, link: `${p}/tutorial/getting-started`, activeMatch: `${p}/tutorial/` },
    { text: t.howto, link: `${p}/howto/integrate-nene`, activeMatch: `${p}/howto/` },
    {
      text: t.explanation,
      link: `${p}/explanation/scope`,
      activeMatch: `${p}/explanation/`,
    },
    { text: t.reference, link: `${p}/reference/environment-variables`, activeMatch: `${p}/reference/` },
    {
      text: t.integrations,
      link: `${p}/integrations/ecosystem`,
      activeMatch: `${p}/integrations/`,
    },
    {
      text: 'v0.1.3',
      items: [
        {
          text: 'Packagist',
          link: 'https://packagist.org/packages/hideyukimori/nene-mcp',
        },
        {
          text: 'Changelog',
          link: 'https://github.com/hideyukiMORI/nene-mcp/blob/main/CHANGELOG.md',
        },
        {
          text: 'Releases',
          link: 'https://github.com/hideyukiMORI/nene-mcp/releases',
        },
        { text: 'NENE2 (PHP)', link: 'https://hideyukimori.github.io/NENE2/' },
        { text: 'nene2-js', link: 'https://hideyukimori.github.io/nene2-js/' },
      ],
    },
  ];
}

function sidebar(t: SidebarLabels, p: string = '') {
  return {
    [`${p}/tutorial/`]: [
      {
        text: t.tutorialGroup,
        items: [
          { text: t.gettingStarted, link: `${p}/tutorial/getting-started` },
          { text: t.cursorSetup, link: `${p}/tutorial/cursor-setup` },
        ],
      },
    ],
    [`${p}/howto/`]: [
      {
        text: t.howtoGroup,
        items: [
          { text: t.integrateNene, link: `${p}/howto/integrate-nene` },
          { text: t.otherPlatforms, link: `${p}/howto/other-platforms` },
          { text: t.writeTools, link: `${p}/howto/write-tools-bearer` },
          { text: t.catalogSmoke, link: `${p}/howto/catalog-smoke-test` },
          { text: t.healthCatalog, link: `${p}/howto/health-catalog-example` },
          { text: t.neenePatterns, link: `${p}/howto/neene-catalog-patterns` },
        ],
      },
    ],
    [`${p}/explanation/`]: [
      {
        text: t.explGroup,
        items: [
          { text: t.scope, link: `${p}/explanation/scope` },
          { text: t.architecture, link: `${p}/explanation/architecture` },
          { text: t.security, link: `${p}/explanation/security-model` },
        ],
      },
    ],
    [`${p}/reference/`]: [
      {
        text: t.refGroup,
        items: [
          { text: t.envVars, link: `${p}/reference/environment-variables` },
          { text: t.mcpProtocol, link: `${p}/reference/mcp-protocol` },
          { text: t.catalogFormat, link: `${p}/reference/catalog-format` },
        ],
      },
    ],
    [`${p}/integrations/`]: [
      {
        text: t.intGroup,
        items: [{ text: t.ecosystem, link: `${p}/integrations/ecosystem` }],
      },
    ],
    [`${p}/contributing/`]: [
      {
        text: t.contribGroup,
        items: [
          { text: t.fieldTrials, link: `${p}/contributing/field-trials` },
          { text: t.methodology, link: `${p}/contributing/quality-strategy` },
        ],
      },
    ],
  };
}

const enNav: NavLabels = {
  tutorial: 'Tutorial',
  howto: 'HOWTO',
  explanation: 'Explanation',
  reference: 'Reference',
  integrations: 'Integrations',
};

const enSide: SidebarLabels = {
  tutorialGroup: 'Tutorial',
  gettingStarted: 'Getting started',
  cursorSetup: 'Cursor / MCP client setup',
  howtoGroup: 'HOWTO',
  integrateNene: 'Integrate with NeNe',
  otherPlatforms: 'Other platforms',
  writeTools: 'Write tools & Bearer',
  catalogSmoke: 'Catalog smoke test',
  healthCatalog: 'NeNe health catalog example',
  neenePatterns: 'NeNe catalog patterns',
  explGroup: 'Explanation',
  scope: 'Scope & mission',
  architecture: 'Architecture',
  security: 'Security model',
  refGroup: 'Reference',
  envVars: 'Environment variables',
  mcpProtocol: 'MCP protocol surface',
  catalogFormat: 'Tool catalog JSON',
  intGroup: 'Integrations',
  ecosystem: 'Ecosystem map',
  contribGroup: 'Contributors',
  fieldTrials: 'Field trials',
  methodology: 'Quality strategy',
};

const jaNav: NavLabels = {
  tutorial: 'チュートリアル',
  howto: 'HOWTO',
  explanation: '解説',
  reference: 'リファレンス',
  integrations: '連携',
};

const jaSide: SidebarLabels = {
  tutorialGroup: 'チュートリアル',
  gettingStarted: 'はじめに',
  cursorSetup: 'Cursor / MCP クライアント設定',
  howtoGroup: 'HOWTO',
  integrateNene: 'NeNe 連携',
  otherPlatforms: 'その他プラットフォーム',
  writeTools: '書き込みツールと Bearer',
  catalogSmoke: 'カタログ smoke テスト',
  healthCatalog: 'NeNe health カタログ例',
  neenePatterns: 'NeNe カタログパターン',
  explGroup: '解説',
  scope: 'スコープとミッション',
  architecture: 'アーキテクチャ',
  security: 'セキュリティモデル',
  refGroup: 'リファレンス',
  envVars: '環境変数',
  mcpProtocol: 'MCP プロトコル',
  catalogFormat: 'ツールカタログ JSON',
  intGroup: '連携',
  ecosystem: 'エコシステム',
  contribGroup: 'コントリビューター',
  fieldTrials: 'フィールドトライアル',
  methodology: '品質戦略',
};

const frNav: NavLabels = {
  tutorial: 'Tutoriel',
  howto: 'Guides',
  explanation: 'Explication',
  reference: 'Référence',
  integrations: 'Intégrations',
};

const frSide: SidebarLabels = {
  tutorialGroup: 'Tutoriel',
  gettingStarted: 'Premiers pas',
  cursorSetup: 'Configuration Cursor / MCP',
  howtoGroup: 'Guides pratiques',
  integrateNene: 'Intégrer avec NeNe',
  otherPlatforms: 'Autres plateformes',
  writeTools: 'Outils d’écriture & Bearer',
  catalogSmoke: 'Test smoke du catalogue',
  healthCatalog: 'Exemple catalogue health NeNe',
  neenePatterns: 'Motifs catalogue NeNe',
  explGroup: 'Explication',
  scope: 'Périmètre & mission',
  architecture: 'Architecture',
  security: 'Modèle de sécurité',
  refGroup: 'Référence',
  envVars: 'Variables d’environnement',
  mcpProtocol: 'Surface MCP',
  catalogFormat: 'JSON du catalogue',
  intGroup: 'Intégrations',
  ecosystem: 'Écosystème',
  contribGroup: 'Contributeurs',
  fieldTrials: 'Field trials',
  methodology: 'Stratégie qualité',
};

const zhNav: NavLabels = {
  tutorial: '教程',
  howto: '操作指南',
  explanation: '说明',
  reference: '参考',
  integrations: '集成',
};

const zhSide: SidebarLabels = {
  tutorialGroup: '教程',
  gettingStarted: '入门',
  cursorSetup: 'Cursor / MCP 客户端配置',
  howtoGroup: '操作指南',
  integrateNene: '集成 NeNe',
  otherPlatforms: '其他平台',
  writeTools: '写入工具与 Bearer',
  catalogSmoke: '目录 smoke 测试',
  healthCatalog: 'NeNe health 目录示例',
  neenePatterns: 'NeNe 目录模式',
  explGroup: '说明',
  scope: '范围与使命',
  architecture: '架构',
  security: '安全模型',
  refGroup: '参考',
  envVars: '环境变量',
  mcpProtocol: 'MCP 协议',
  catalogFormat: '工具目录 JSON',
  intGroup: '集成',
  ecosystem: '生态地图',
  contribGroup: '贡献者',
  fieldTrials: '现场试验',
  methodology: '质量策略',
};

const ptNav: NavLabels = {
  tutorial: 'Tutorial',
  howto: 'Guias',
  explanation: 'Explicação',
  reference: 'Referência',
  integrations: 'Integrações',
};

const ptSide: SidebarLabels = {
  tutorialGroup: 'Tutorial',
  gettingStarted: 'Primeiros passos',
  cursorSetup: 'Configuração Cursor / MCP',
  howtoGroup: 'Guias práticos',
  integrateNene: 'Integrar com NeNe',
  otherPlatforms: 'Outras plataformas',
  writeTools: 'Ferramentas de escrita & Bearer',
  catalogSmoke: 'Smoke test do catálogo',
  healthCatalog: 'Exemplo catálogo health NeNe',
  neenePatterns: 'Padrões de catálogo NeNe',
  explGroup: 'Explicação',
  scope: 'Escopo & missão',
  architecture: 'Arquitetura',
  security: 'Modelo de segurança',
  refGroup: 'Referência',
  envVars: 'Variáveis de ambiente',
  mcpProtocol: 'Superfície MCP',
  catalogFormat: 'JSON do catálogo',
  intGroup: 'Integrações',
  ecosystem: 'Ecossistema',
  contribGroup: 'Contribuidores',
  fieldTrials: 'Field trials',
  methodology: 'Estratégia de qualidade',
};

const deNav: NavLabels = {
  tutorial: 'Tutorial',
  howto: 'Anleitungen',
  explanation: 'Erklärung',
  reference: 'Referenz',
  integrations: 'Integrationen',
};

const deSide: SidebarLabels = {
  tutorialGroup: 'Tutorial',
  gettingStarted: 'Erste Schritte',
  cursorSetup: 'Cursor / MCP-Client einrichten',
  howtoGroup: 'Anleitungen',
  integrateNene: 'NeNe integrieren',
  otherPlatforms: 'Andere Plattformen',
  writeTools: 'Schreib-Tools & Bearer',
  catalogSmoke: 'Katalog-Smoke-Test',
  healthCatalog: 'NeNe Health-Katalog Beispiel',
  neenePatterns: 'NeNe-Katalogmuster',
  explGroup: 'Erklärung',
  scope: 'Umfang & Mission',
  architecture: 'Architektur',
  security: 'Sicherheitsmodell',
  refGroup: 'Referenz',
  envVars: 'Umgebungsvariablen',
  mcpProtocol: 'MCP-Protokoll',
  catalogFormat: 'Tool-Katalog JSON',
  intGroup: 'Integrationen',
  ecosystem: 'Ökosystem',
  contribGroup: 'Mitwirkende',
  fieldTrials: 'Field Trials',
  methodology: 'Qualitätsstrategie',
};

const editPattern = 'https://github.com/hideyukiMORI/nene-mcp/edit/main/docs/:path';

export default defineConfig({
  title: 'nene-mcp',
  description:
    'Standalone PHP stdio MCP bridge for NeNe / NENE2 OpenAPI tool catalogs — Composer install, Cursor-ready.',
  base: process.env.GITHUB_ACTIONS ? '/nene-mcp/' : '/',
  srcDir: './docs',
  outDir: './.vitepress/dist',
  cleanUrls: true,
  ignoreDeadLinks: true,

  srcExclude: [
    '**/field-trials/2026-05-field-trial-*.md',
    '**/field-trials/index-ft10-200.md',
    '**/field-trials/milestones/**',
    '**/templates/**',
    '**/todo/**',
    '**/review/**',
    '**/adr/**',
    '**/integration/**',
    '**/development/**',
    'project.md',
    'workflow.md',
    'CONTRIBUTING.md',
    'example-ne-health-catalog.md',
    'guide/**',
  ],

  head: [
    ['meta', { name: 'theme-color', content: '#7c3aed' }],
    ['link', { rel: 'icon', href: '/favicon.svg', type: 'image/svg+xml' }],
  ],

  locales: {
    root: {
      label: 'English',
      lang: 'en',
      themeConfig: {
        nav: nav(enNav),
        sidebar: sidebar(enSide),
        editLink: { pattern: editPattern, text: 'Edit this page on GitHub' },
        footer: {
          message: 'Released under the MIT License.',
          copyright: 'Copyright © 2026 hideyukiMORI',
        },
      },
    },

    ja: {
      label: '日本語',
      lang: 'ja',
      themeConfig: {
        nav: nav(jaNav, '/ja'),
        sidebar: sidebar(jaSide, '/ja'),
        editLink: { pattern: editPattern, text: 'GitHub でこのページを編集' },
        footer: {
          message: 'MIT ライセンスの下で公開されています。',
          copyright: 'Copyright © 2026 hideyukiMORI',
        },
        docFooter: { prev: '前のページ', next: '次のページ' },
        outlineTitle: 'このページの目次',
        returnToTopLabel: 'トップへ戻る',
        sidebarMenuLabel: 'メニュー',
        darkModeSwitchLabel: 'ダークモード',
      },
    },

    fr: {
      label: 'Français',
      lang: 'fr',
      themeConfig: {
        nav: nav(frNav, '/fr'),
        sidebar: sidebar(frSide, '/fr'),
        editLink: { pattern: editPattern, text: 'Modifier cette page sur GitHub' },
        footer: {
          message: 'Publié sous licence MIT.',
          copyright: 'Copyright © 2026 hideyukiMORI',
        },
        docFooter: { prev: 'Page précédente', next: 'Page suivante' },
        outlineTitle: 'Sur cette page',
        returnToTopLabel: 'Retour en haut',
      },
    },

    zh: {
      label: '中文',
      lang: 'zh-Hans',
      themeConfig: {
        nav: nav(zhNav, '/zh'),
        sidebar: sidebar(zhSide, '/zh'),
        editLink: { pattern: editPattern, text: '在 GitHub 上编辑此页' },
        footer: {
          message: '基于 MIT 许可证发布。',
          copyright: 'Copyright © 2026 hideyukiMORI',
        },
        docFooter: { prev: '上一页', next: '下一页' },
        outlineTitle: '本页目录',
        returnToTopLabel: '返回顶部',
        sidebarMenuLabel: '菜单',
        darkModeSwitchLabel: '深色模式',
      },
    },

    'pt-br': {
      label: 'Português (Brasil)',
      lang: 'pt-BR',
      themeConfig: {
        nav: nav(ptNav, '/pt-br'),
        sidebar: sidebar(ptSide, '/pt-br'),
        editLink: { pattern: editPattern, text: 'Editar esta página no GitHub' },
        footer: {
          message: 'Publicado sob a licença MIT.',
          copyright: 'Copyright © 2026 hideyukiMORI',
        },
        docFooter: { prev: 'Página anterior', next: 'Próxima página' },
        outlineTitle: 'Nesta página',
        returnToTopLabel: 'Voltar ao topo',
      },
    },

    de: {
      label: 'Deutsch',
      lang: 'de',
      themeConfig: {
        nav: nav(deNav, '/de'),
        sidebar: sidebar(deSide, '/de'),
        editLink: { pattern: editPattern, text: 'Diese Seite auf GitHub bearbeiten' },
        footer: {
          message: 'Veröffentlicht unter der MIT-Lizenz.',
          copyright: 'Copyright © 2026 hideyukiMORI',
        },
        docFooter: { prev: 'Vorherige Seite', next: 'Nächste Seite' },
        outlineTitle: 'Auf dieser Seite',
        returnToTopLabel: 'Nach oben',
        sidebarMenuLabel: 'Menü',
        darkModeSwitchLabel: 'Dunkelmodus',
      },
    },
  },

  themeConfig: {
    siteTitle: 'nene-mcp',
    logo: '/logo.svg',
    socialLinks: [{ icon: 'github', link: 'https://github.com/hideyukiMORI/nene-mcp' }],
    search: { provider: 'local' },
    outline: { level: [2, 3] },
  },

  markdown: {
    theme: { light: 'github-light', dark: 'one-dark-pro' },
    lineNumbers: true,
  },
});
