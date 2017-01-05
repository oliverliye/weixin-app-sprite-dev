_ = require 'underscore'


defParams = 
    method: 'GET'
    dataType: 'json'

export default (params)->

        params = _.extend {}, defParams, params

        contentType = 'application/json'

        req = new XMLHttpRequest()
        
        req.onerror = ()-> params.fail()

        req.onloadend = ()->
            if @status is 200 or @status is 304
                params.success? @response
            params.complete?()

        req.open params.method, params.url, true

        req.timeout = 60 * 1000
        req.responseType = params.dataType

        if params.hasOwnProperty 'header'
            if params['header'].hasOwnProperty 'content-type'
                contentType = params['header']['content-type']
            req.setRequestHeader head, value for head, value of params.header    

        try
            data = ''
            if _.isObject params.data
                if contentType is 'application/json'
                    data = JSON.parse params.data
                else if contentType is 'application/x-www-form-urlencoded'
                    data += "#{encodeURIComponent(k)}&#{encodeURIComponent(v)}&" for k, v of params.data
            else
                data = params.data

            req.send data
        catch e
            params.fail?()
            params.complete?()