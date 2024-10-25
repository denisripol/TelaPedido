object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 513
  ClientWidth = 933
  Color = clBtnFace
  DefaultMonitor = dmMainForm
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  TextHeight = 15
  object gridPedido: TDBGrid
    Left = 0
    Top = 92
    Width = 931
    Height = 381
    DataSource = dsPedidoItens
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
    OnCellClick = gridPedidoCellClick
    OnColEnter = gridPedidoColEnter
    OnColExit = gridPedidoColExit
    OnKeyDown = gridPedidoKeyDown
    Columns = <
      item
        Expanded = False
        FieldName = 'id_produto'
        Title.Caption = 'ID Produto'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'nome_produto'
        Title.Caption = 'Produto'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'quantidade'
        Title.Caption = 'Quantidade'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'valor_unitario'
        Title.Caption = 'Valor Unit.'
        Width = 78
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'valor_total'
        Title.Caption = 'Valor Total'
        Width = 108
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'id_pedido'
        Visible = False
      end>
  end
  object Panel1: TPanel
    Left = 0
    Top = 472
    Width = 931
    Height = 41
    TabOrder = 1
    object Label1: TLabel
      Left = 765
      Top = 11
      Width = 55
      Height = 15
      Caption = 'Valor Total'
    end
    object edtSumValor: TEdit
      Left = 827
      Top = 7
      Width = 98
      Height = 23
      TabOrder = 0
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = -1
    Width = 931
    Height = 94
    TabOrder = 2
    object lblCliente: TLabel
      Left = 0
      Top = 7
      Width = 37
      Height = 15
      Caption = 'Cliente'
    end
    object lblProduto: TLabel
      Left = 344
      Top = 7
      Width = 43
      Height = 15
      Caption = 'Produto'
    end
    object lblValor: TLabel
      Left = 658
      Top = 8
      Width = 26
      Height = 15
      Caption = 'Valor'
    end
    object lblQuantidade: TLabel
      Left = 766
      Top = 8
      Width = 62
      Height = 15
      Caption = 'Quantidade'
    end
    object lblPedido: TLabel
      Left = 6
      Top = 66
      Width = 87
      Height = 15
      Caption = 'N'#250'mero Pedido:'
    end
    object cbCliente: TDBLookupComboBox
      Left = 0
      Top = 24
      Width = 337
      Height = 23
      KeyField = 'id'
      ListField = 'Nome'
      ListSource = dsCliente
      TabOrder = 0
      OnExit = cbClienteExit
    end
    object cbProduto: TDBLookupComboBox
      Left = 344
      Top = 24
      Width = 309
      Height = 23
      KeyField = 'id'
      ListField = 'nome'
      ListSource = dsProduto
      TabOrder = 1
      OnExit = cbProdutoExit
    end
    object edtValor: TEdit
      Left = 658
      Top = 24
      Width = 102
      Height = 23
      TabOrder = 2
    end
    object edtQuantidade: TEdit
      Left = 766
      Top = 24
      Width = 103
      Height = 23
      TabOrder = 3
    end
    object Button1: TButton
      Left = 871
      Top = 23
      Width = 54
      Height = 25
      Caption = 'Incluir'
      ImageIndex = 0
      Images = cxImageList1
      TabOrder = 4
      OnClick = Button1Click
    end
    object edtPedido: TEdit
      Left = 96
      Top = 63
      Width = 121
      Height = 23
      Enabled = False
      TabOrder = 5
      Text = 'edtPedido'
    end
  end
  object Conexao: TFDConnection
    Params.Strings = (
      'Database=PEDIDO'
      'User_Name=castrillon'
      'Password=castri123'
      'Compress='
      'UseSSL=True'
      'ReadTimeout=3600'
      'WriteTimeout=3600'
      'CharacterSet=utf8mb4'
      'Server=172.16.3.88'
      'DriverID=MySQL')
    Connected = True
    LoginPrompt = False
    Left = 536
    Top = 264
  end
  object FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink
    VendorLib = 'D:\_SAV\30\Build\Win32\libmysql.dll'
    Left = 640
    Top = 384
  end
  object dsCliente: TDataSource
    DataSet = qyCliente
    Left = 440
    Top = 336
  end
  object qyCliente: TFDQuery
    Connection = Conexao
    SQL.Strings = (
      
        'SELECT concat(Nome,'#39' - '#39',Cidade, '#39' - '#39', UF) nome,nome nome_c, id' +
        '  FROM clientes')
    Left = 496
    Top = 336
    object qyClientenome: TWideStringField
      AutoGenerateValue = arDefault
      FieldName = 'nome'
      Origin = 'nome'
      ProviderFlags = []
      ReadOnly = True
      Size = 170
    end
    object qyClienteid: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = False
    end
    object qyClientenome_c: TWideStringField
      AutoGenerateValue = arDefault
      FieldName = 'nome_c'
      Origin = 'Nome'
      Size = 93
    end
  end
  object qyProduto: TFDQuery
    Connection = Conexao
    SQL.Strings = (
      
        'SELECT concat(descricao,'#39' - '#39', preco_venda) nome, id, preco_vend' +
        'a FROM produtos')
    Left = 504
    Top = 416
    object qyProdutonome: TWideStringField
      AutoGenerateValue = arDefault
      FieldName = 'nome'
      Origin = 'nome'
      ProviderFlags = []
      ReadOnly = True
      Size = 113
    end
    object qyProdutoid: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = False
    end
    object qyProdutopreco_venda: TBCDField
      FieldName = 'preco_venda'
      Origin = 'preco_venda'
      Required = True
      Precision = 10
      Size = 2
    end
  end
  object dsProduto: TDataSource
    DataSet = qyProduto
    Left = 432
    Top = 400
  end
  object cxImageList1: TcxImageList
    SourceDPI = 96
    FormatVersion = 1
    DesignInfo = 17302248
    ImageInfo = <
      item
        ImageClass = 'TdxPNGImage'
        Image.Data = {
          89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
          610000000473424954080808087C086488000000097048597300000076000000
          76014E7B26080000001974455874536F667477617265007777772E696E6B7363
          6170652E6F72679BEE3C1A000001F449444154388D63601808203CCB2B417CB6
          EF3C06060606165235F34EF108E466639FF4EDCF9FC70C0C0C0C4CA468669DE0
          612ACCC3399D9B8DF5CF871FBF534833A0DF454998977D839FB6B2F0AB2F3FB6
          FDC9D9719C7803A6380B8B7273EDAD7034965A71F1F68BB75F3FE5C0A4081BD0
          67C929CCC6BDBFC4C1406ED7AD47EFBF7EFF5DCE5078E0034C9A858181814168
          966F181323632B03C3FFAB6FDE31C632946FFACCC0C0C0C0B02A9459E8E38F1D
          E9E63AEA1C2C2C4C271FBFBCF13577DB3264F39918FE333072B030F7CF087450
          C934D7F51616F87F82A1DB4D8C81818141E8C3CF2521BACA26A632A26C138F5E
          7AF1F6C7CF6874073231AC0E65FAFDF7EFFFBF0CFF188C654559AA5C4C344405
          384EF0CEF09E69A728E1E9A52ECFB5E3D6C36FEFBF7D9FCB90BBEB3EBA01CC0C
          ABAFFD6772537978EBED07675B25492E214E0E4673597141715E2EED205D259E
          8FDF7F314C3C72F1E1BBFFCFC318B63CFF8769000303C3AFEDB7AF7F779417FC
          FEE78FAEAE8430070F3B2B83B2303F0B23032343FFE18B6FEFBFFB1CF52FFB30
          86ED28B1F03E634BD5AEDB8F8F9D78FCE2274CECCACBB77FEFBDF978F04FDECE
          C3B82209118D8C0CFFDFFF670C997DFCDAFD471FBE30FCF8F39761EAB1CB2F5E
          7FFD958A4B33441B3A98E42923C6C9BA99899191FFF3AF1F695FB376EEC16700
          C5000017F1BA1C0300FB210000000049454E44AE426082}
      end>
  end
  object dsPedido: TDataSource
    DataSet = qyPedido
    Left = 640
    Top = 264
  end
  object qyPedido: TFDQuery
    Connection = Conexao
    SQL.Strings = (
      'SELECT id,'
      #9#9'data_emissao,'
      '        id_cliente,'
      
        '        (select c.nome from clientes c where c.id = p.id_cliente' +
        ') nome_cliente,'
      '        p.valor_total'
      'FROM pedidos p'
      'where p.id = :pedido')
    Left = 696
    Top = 264
    ParamData = <
      item
        Name = 'PEDIDO'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
    object qyPedidoid: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = False
    end
    object qyPedidodata_emissao: TDateTimeField
      AutoGenerateValue = arDefault
      FieldName = 'data_emissao'
      Origin = 'data_emissao'
    end
    object qyPedidoid_cliente: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'id_cliente'
      Origin = 'id_cliente'
    end
    object qyPedidovalor_total: TBCDField
      AutoGenerateValue = arDefault
      FieldName = 'valor_total'
      Origin = 'valor_total'
      Precision = 10
      Size = 2
    end
    object qyPedidonome_cliente: TWideStringField
      AutoGenerateValue = arDefault
      FieldName = 'nome_cliente'
      Origin = 'nome_cliente'
      ProviderFlags = []
      ReadOnly = True
      Size = 93
    end
  end
  object qyPedidoItens: TFDQuery
    Connection = Conexao
    SQL.Strings = (
      'select pi.*,'
      
        #9'   (select pr.descricao from produtos pr where pr.id = pi.id_pr' +
        'oduto) nome_produto,'
      
        '       (select (select c.nome from clientes c where c.id = pd.id' +
        '_cliente) nome_cliente '
      '           from pedidos pd '
      '           where pd.id = pi.id_pedido) cliente'
      'from pedidos_itens pi'
      'where pi.id_pedido = :id_pedido')
    Left = 696
    Top = 328
    ParamData = <
      item
        Name = 'ID_PEDIDO'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
    object qyPedidoItensid: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = False
    end
    object qyPedidoItensid_pedido: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'id_pedido'
      Origin = 'id_pedido'
    end
    object qyPedidoItensid_produto: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'id_produto'
      Origin = 'id_produto'
    end
    object qyPedidoItensquantidade: TLargeintField
      AutoGenerateValue = arDefault
      FieldName = 'quantidade'
      Origin = 'quantidade'
    end
    object qyPedidoItensvalor_unitario: TBCDField
      AutoGenerateValue = arDefault
      FieldName = 'valor_unitario'
      Origin = 'valor_unitario'
      Precision = 10
      Size = 2
    end
    object qyPedidoItensvalor_total: TBCDField
      AutoGenerateValue = arDefault
      FieldName = 'valor_total'
      Origin = 'valor_total'
      Precision = 10
      Size = 2
    end
    object qyPedidoItensnome_produto: TWideStringField
      AutoGenerateValue = arDefault
      FieldName = 'nome_produto'
      Origin = 'nome_produto'
      ProviderFlags = []
      ReadOnly = True
      Size = 93
    end
    object qyPedidoItenscliente: TWideStringField
      AutoGenerateValue = arDefault
      FieldName = 'cliente'
      Origin = 'cliente'
      ProviderFlags = []
      ReadOnly = True
      Size = 93
    end
  end
  object dsPedidoItens: TDataSource
    DataSet = qyPedidoItens
    Left = 640
    Top = 328
  end
  object qyConsultaPedido: TFDQuery
    Connection = Conexao
    SQL.Strings = (
      'SELECT *'
      'FROM pedidos p'
      'where p.id_cliente = :cliente')
    Left = 776
    Top = 336
    ParamData = <
      item
        Name = 'CLIENTE'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
    object qyConsultaPedidoid: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = False
    end
    object qyConsultaPedidodata_emissao: TDateTimeField
      AutoGenerateValue = arDefault
      FieldName = 'data_emissao'
      Origin = 'data_emissao'
    end
    object qyConsultaPedidoid_cliente: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'id_cliente'
      Origin = 'id_cliente'
    end
    object qyConsultaPedidovalor_total: TBCDField
      AutoGenerateValue = arDefault
      FieldName = 'valor_total'
      Origin = 'valor_total'
      Precision = 10
      Size = 2
    end
  end
end
