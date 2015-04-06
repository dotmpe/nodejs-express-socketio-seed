requirejs.config({
    baseUrl: '/script',
    dir: '.',
    deps: [
        'dotmpe/client-seed/index',
    ],
    paths: {
        components: '../components',
        jquery: '/components/jquery/dist/jquery',
    },
    bundles: {
        'dotmpe/client-seed': [
            'dotmpe/client-seed/index',
            'dotmpe/client-seed/navbar',
            'dotmpe/client-seed/document',
            'dotmpe/client-seed/socket',
            'dotmpe/client-seed/custom'
        ]
    }
});
