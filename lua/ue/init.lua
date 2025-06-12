local ue = {}

function ue.setup(opts)
    require('ue.path').setUpVersionsConfig(opts.versions)
end

return ue;
