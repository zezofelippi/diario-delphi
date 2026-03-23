object WebModule1: TWebModule1
  OldCreateOrder = False
  Actions = <
    item
      Default = True
      Name = 'DefaultHandler'
      PathInfo = '/'
      OnAction = WebModule1DefaultHandlerAction
    end
    item
      MethodType = mtGet
      Name = 'WebActionItem1'
      PathInfo = '/teste'
      OnAction = WebModule1WebActionItem1Action
    end
    item
      MethodType = mtGet
      Name = 'actIndex'
      PathInfo = '/index'
    end
    item
      MethodType = mtGet
      Name = 'tipoAtividadeGet'
      PathInfo = '/tipoatividade'
    end
    item
      MethodType = mtPost
      Name = 'tipoAtividadePost'
      PathInfo = '/tipoatividade'
    end>
  BeforeDispatch = WebModuleBeforeDispatch
  Height = 230
  Width = 415
end
