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
      Name = 'actListarTipoAtividade'
      PathInfo = '/atividade/listar'
    end>
  BeforeDispatch = WebModuleBeforeDispatch
  Height = 230
  Width = 415
end
