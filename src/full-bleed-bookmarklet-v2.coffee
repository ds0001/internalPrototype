# cat jquery-2.1.3.min.js query-string.js full-bleed-bookmarklet-v2.js > full-bleed.js

do ->
    'use strict'
    
    if typeof(NYTD) == "undefined"
        window.NYTD = {}
    window.NYTD.InternalPrototype = {}
    CONFIG =
        "prototypes":
            "Full Bleed":
                "on": true,
                "settings":
                    "safezone": "1,2,3,4"
                    "image": ""
    window.NYTD.InternalPrototype.reload = () ->
        console.log "reload"
        $('.internalPrototype-prototype').each ->
            name = $(this).find('.prototypename').text()
            if $(this).find("input[type=checkbox]").prop("checked")
                console.log 'found',this
                $(this).find('.internalPrototype-prototype-setting').each ->
                    console.log $(this).find('input[type=text]').val()
                    val = $(this).find('input[type=text]').val()
                    console.log name
                    console.log $(this).find('.settingname').text()
                    settingname = $(this).find('.settingname').text()
                    # console.log CONFIG.prototypes[name]
                    console.log CONFIG.prototypes[name].settings[settingname]
                    CONFIG.prototypes[name].settings[settingname] = val
            # console.log CONFIG



        for name of CONFIG.prototypes
            if CONFIG.prototypes[name].on
                #console.log decodeURIComponent(JSON.stringify(CONFIG.prototypes[name].settings))
                queryStringObj =
                    prototype: name
                    on: CONFIG.prototypes[name].on
                    settings: decodeURIComponent(JSON.stringify(CONFIG.prototypes[name].settings))
        #console.log 'queryStringObj',queryStringObj
        #console.log 'queryString.stringify(queryStringObj)',decodeURIComponent(queryString.stringify(queryStringObj))
        location.search = decodeURIComponent(queryString.stringify(queryStringObj))

    if location.search
        qs = queryString.parse(location.search)
        settings = JSON.parse(qs.settings)
    else
        # console.log queryString.stringify(CONFIG);
        for name of CONFIG.prototypes
            if CONFIG.prototypes[name].on
                queryStringObj =
                    prototype: name
                    on: CONFIG.prototypes[name].on
                    settings: decodeURIComponent(JSON.stringify(CONFIG.prototypes[name].settings))
                # for setting of CONFIG.prototypes[name].settings
                #     console.log 'CONFIG.prototypes[name].settings[setting]',CONFIG.prototypes[name].settings[setting]
                #     queryStringObj.settings += setting + ":" + CONFIG.prototypes[name].settings[setting]
                # #     settings: queryString.stringify(CONFIG.prototypes[name].settings)
                # console.log 'queryStringObj',queryStringObj
                # console.log queryString.stringify(queryStringObj)
        location.search = decodeURIComponent(queryString.stringify(queryStringObj))
        return

    for name of CONFIG.prototypes
        CONFIG.prototypes[name].on = qs.on == "true"
        for setting of CONFIG.prototypes[name].settings
            CONFIG.prototypes[name].settings[setting] = settings[setting]

    $('#internalPrototype-overlay').remove()

    $overlay = $("""
        <div id="internalPrototype-overlay" style="
            position: fixed; z-index: 9999; top: 0; bottom: 0; left: 0; right: 0;
            background-color: rgba(0,0,0,0.8); cursor: pointer;
        ">
            <style>
                #internalPrototype {
                    margin: 12px 18px; padding: 1px 18px; background-color: #eee;
                    font: 14px helvetica, arial, sans-serif;
                    -webkit-user-select:none;
                    -khtml-user-select:none;
                    -moz-user-select:none;
                    -o-user-select:none;
                    user-select:none;
                    cursor: default;
                }
                #internalPrototype .nonstring {
                    font-style: italic;
                }
                #internalPrototype input, #internalPrototype label {
                    cursor: pointer;
                }
                #internalPrototype label {
                    margin: 6px 0;
                }
                #internalPrototype .internalPrototype-prototype:not(.forced) .internalPrototype-prototype-variant input,
                #internalPrototype .internalPrototype-prototype:not(.forced) .internalPrototype-prototype-variant label {
                    cursor: default;
                    color: #999;
                }
                .internalPrototype-prototype {
                    margin: 12px 0;
                }
                .internalPrototype-prototype-name {
                    display: block
                }
                .internalPrototype-prototype-variant {
                    display: block;
                    margin-left: 18px
                }
            </style>
            <div id="internalPrototype">
                <p><b>Prototypes (v1):</b></p>
            </div>
        </div>
    """)
    $overlay.on 'click', (e) -> $overlay.remove()

    $internalPrototype = $overlay.find('#internalPrototype')
    $internalPrototype.on 'click', (e) -> e.stopPropagation()

    # fvs = {}
    # force = localStorage['NYT.INTERNALPROTOTYPE.F']
    # if force
    #     fvs = JSON.parse(force)

    prototypeIndex = 0

    for prototypeName, prototypeConfig of CONFIG.prototypes
        prototypeIndex += 1

        $prototypeDiv = $("""
            <div class="internalPrototype-prototype">
                <div class="internalPrototype-prototype-name"><label>
                    <input type="checkbox"> <span class="prototypename"></span>:
                </label></div>
            </div>
        """)
        $prototypeDiv.find('.prototypename').text(prototypeName)
        # $prototypeDiv.find('input[type=text]').prop("checked",true)
        $prototypeDiv.find('input[type=checkbox]').prop('checked', prototypeConfig.on)

        doneValues = []
        for value of prototypeConfig.settings
            continue if value in doneValues
            doneValues.push value

            labelText = if typeof value is 'string' then value else String(value)
            $settingDiv = $("""
                <div class="internalPrototype-prototype-setting"><label>
                    <span class="settingname"></span>
                    <input type="text" name="prototype-#{prototypeIndex}-setting-text" />
                </label></div>
            """)
            $settingDiv.find('.settingname').addClass('nonstring' if typeof value isnt 'string').text(labelText)
            # $prototypeDiv.find('input[type=text]').value(value)

            # $settingDiv.append("*") if value == NYTD.InternalPrototype.variantFor(prototypeName, true)

            $settingCheckbox = $settingDiv.find('input[type=checkbox]')
            $settingTextbox = $settingDiv.find('input[type=text]')
            $settingTextbox.val(prototypeConfig.settings[value])
            $settingCheckbox.data('value', value).data('prototypeName', prototypeName)
            # $settingTextbox.prop('disabled', (prototypeName not of fvs))
            # $settingRadio.prop('checked', if (prototypeName of fvs) then (fvs[prototypeName] == value) else (value == NYTD.ABTest.variantFor(prototypeName, true)))

            $settingDiv.appendTo $prototypeDiv

        $prototypeDiv.appendTo $internalPrototype

    $internalPrototype.append("""
        <p style="font-size: smaller">* currently active; <a href="#" onclick="window.NYTD.InternalPrototype.reload(); return false">reload</a> to apply changes</p>
    """)

    # $('.internalPrototype-prototype-setting input[type=text]').on 'change', (e) ->
    #     console.log "change"
    #     target = e.target
    #     return unless target

    #     fvs = {}
    #     $internalPrototype.find('.internalPrototype-prototype').each ->
    #         $prototypeDiv = $(this)
            # $settingCheckboxes = $(".internalPrototype-prototype-setting").find('input[type=checkbox]')

            # if ($prototypeDiv.find('input[type=checkbox]').prop('checked'))
            #     $prototypeDiv.addClass('forced')
            #     $settingCheckboxes.prop('disabled', false)
            #     $selectedSettingCheckbox = $settingCheckboxes.filter(':checked')
            #     if $selectedSettingCheckbox.length
            #         fvs[$selectedSettingCheckbox.data('prototypeName')] = $selectedSettingCheckbox.data('value')
            # else
            #     $prototypeDiv.removeClass('forced')
            #     $settingCheckboxes.prop('disabled', true)

        # if Object.keys(fvs).length
        #     console?.log? fvs
        #     localStorage['NYT.INTERNALPROTOTYPE.F'] = JSON.stringify(fvs)
        # else
        #     localStorage.removeItem('NYT.INTERNALPROTOTYPE.F')


    $(document.body).append($overlay)

    return

return
