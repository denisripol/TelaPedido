unit Pedido;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, Vcl.StdCtrls, Vcl.DBCtrls, System.ImageList,
  Vcl.ImgList, cxImageList, cxGraphics, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls;

type
  TForm1 = class(TForm)
    Conexao: TFDConnection;
    FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink;
    dsCliente: TDataSource;
    qyCliente: TFDQuery;
    qyClientenome: TWideStringField;
    qyClienteid: TFDAutoIncField;
    qyProduto: TFDQuery;
    dsProduto: TDataSource;
    qyProdutonome: TWideStringField;
    qyProdutoid: TFDAutoIncField;
    qyProdutopreco_venda: TBCDField;
    cxImageList1: TcxImageList;
    gridPedido: TDBGrid;
    dsPedido: TDataSource;
    qyPedido: TFDQuery;
    qyPedidoItens: TFDQuery;
    dsPedidoItens: TDataSource;
    qyPedidoid: TFDAutoIncField;
    qyPedidodata_emissao: TDateTimeField;
    qyPedidoid_cliente: TIntegerField;
    qyPedidovalor_total: TBCDField;
    qyClientenome_c: TWideStringField;
    qyPedidonome_cliente: TWideStringField;
    qyPedidoItensid: TFDAutoIncField;
    qyPedidoItensid_pedido: TIntegerField;
    qyPedidoItensid_produto: TIntegerField;
    qyPedidoItensquantidade: TLargeintField;
    qyPedidoItensvalor_unitario: TBCDField;
    qyPedidoItensvalor_total: TBCDField;
    qyPedidoItensnome_produto: TWideStringField;
    qyPedidoItenscliente: TWideStringField;
    Panel1: TPanel;
    edtSumValor: TEdit;
    qyConsultaPedido: TFDQuery;
    Panel2: TPanel;
    cbCliente: TDBLookupComboBox;
    lblCliente: TLabel;
    lblProduto: TLabel;
    cbProduto: TDBLookupComboBox;
    lblValor: TLabel;
    edtValor: TEdit;
    lblQuantidade: TLabel;
    edtQuantidade: TEdit;
    Button1: TButton;
    edtPedido: TEdit;
    lblPedido: TLabel;
    qyConsultaPedidoid: TFDAutoIncField;
    qyConsultaPedidodata_emissao: TDateTimeField;
    qyConsultaPedidoid_cliente: TIntegerField;
    qyConsultaPedidovalor_total: TBCDField;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure cbProdutoExit(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure cbClienteExit(Sender: TObject);
    procedure gridPedidoColExit(Sender: TObject);
    procedure gridPedidoCellClick(Column: TColumn);
    procedure gridPedidoColEnter(Sender: TObject);
    procedure gridPedidoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    jaPossuiPedido : string;
    procedure CarregaPedido;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
 ValorTotal, Valor, Quantidade : Double;
begin
  if cbCliente.Text = '' then
  begin
    ShowMessage('Favor Selecionar o Cliente.');
    cbCliente.SetFocus;
    Exit;
  end;

  if cbProduto.Text = '' then
  begin
    ShowMessage('Favor Selecionar o Produto.');
    cbProduto.SetFocus;
    Exit;
  end;

  if edtValor.Text = '' then
  begin
    ShowMessage('Favor digitar o valor.');
    edtValor.SetFocus;
    Exit;
  end;

  if edtQuantidade.Text = '' then
  begin
    ShowMessage('Favor digitar a quantidade.');
    edtQuantidade.SetFocus;
    Exit;
  end;

  Try
    If not qyPedido.Active then
    begin
      qyPedido.Active := True;
      qypedido.Edit;
      qyPedido.Append;
      qyPedido.FieldByName('data_emissao').AsDateTime := Now;
      qyPedido.FieldByName('id_cliente').AsString := qyCliente.FieldByName('id').AsString;
    end;


    Quantidade := StrToFloat(edtQuantidade.Text);
    Valor := strToFloat(edtValor.Text);
    ValorTotal := (Quantidade * Valor);

    if (qypedido.State <> dsEdit) and (qypedido.State <> dsInsert) then
      qypedido.Edit;

    qyPedido.FieldByName('VALOR_TOTAL').AsFloat := qyPedido.FieldByName('VALOR_TOTAL').AsFloat + ValorTotal;
    edtSumValor.Text := qyPedido.FieldByName('VALOR_TOTAL').AsString;

    qyPedido.Post;
    qyPedido.Refresh;

    qyPedidoItens.Active := True;
    qyPedidoItens.Edit;
    qyPedidoItens.Append;

    qyPedidoItens.FieldByName('ID_PEDIDO').AsString := qyPedido.FieldByName('ID').AsString;
    qyPedidoItens.FieldByName('ID_PRODUTO').AsString := qyProduto.FieldByName('ID').AsString;
    qyPedidoItens.FieldByName('QUANTIDADE').AsFloat := Quantidade;
    qyPedidoItens.FieldByName('VALOR_UNITARIO').AsFloat := Valor;
    qyPedidoItens.FieldByName('VALOR_TOTAL').AsFloat := ValorTotal;

    qyPedidoItens.Post;
    qyPedidoItens.Refresh;
  except
   on e:exception do
    begin
      ShowMessage('Houve um problema: ' + e.Message);
    end;
  End;
end;

procedure TForm1.cbClienteExit(Sender: TObject);
begin
  qyConsultaPedido.Params[0].AsInteger := qyCliente.FieldByName('id').AsInteger;
  qyConsultaPedido.Active := true;

  if qyConsultaPedido.RecordCount > 0 then
  begin
    jaPossuiPedido := 'S';
    edtPedido.Text := qyConsultaPedido.FieldByName('ID').AsString;
    CarregaPedido;
  end;
end;

procedure TForm1.CarregaPedido;
begin
  qyPedido.Params[0].AsInteger := qyConsultaPedido.FieldByName('ID').AsInteger;
  qyPedido.Active := True;
  qyPedidoItens.Params[0].AsInteger := qyConsultaPedido.FieldByName('ID').AsInteger;
  qyPedidoItens.Active := true;
end;

procedure TForm1.cbProdutoExit(Sender: TObject);
begin
  edtValor.Text := qyProduto.FieldByName('preco_venda').AsString;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  qyCliente.Active := True;
  qyProduto.Active := True;
  jaPossuiPedido := 'N';
end;

procedure TForm1.gridPedidoCellClick(Column: TColumn);
begin
  if not (qyPedidoItens.State in [dsEdit, dsInsert]) then
    qyPedidoItens.Edit;
end;

procedure TForm1.gridPedidoColEnter(Sender: TObject);
begin
  if GridPedido.SelectedField.FieldName = 'quantidade' then
  begin
    if not (qyPedidoItens.State in [dsEdit, dsInsert]) then
      qyPedidoItens.Edit;
  end;

  if GridPedido.SelectedField.FieldName = 'valor_unitario' then
  begin
    if not (qyPedidoItens.State in [dsEdit, dsInsert]) then
      qyPedidoItens.Edit;
  end;

end;

procedure TForm1.gridPedidoColExit(Sender: TObject);
begin
  if (qyPedidoItens.FieldByName('QUANTIDADE').OldValue <> qyPedidoItens.FieldByName('QUANTIDADE').NewValue) and not VarIsNull((qyPedidoItens.FieldByName('QUANTIDADE').NewValue)) then
  begin
    qyPedidoItens.FieldByName('VALOR_TOTAL').AsFloat := qyPedidoItens.FieldByName('VALOR_UNITARIO').AsFloat * qyPedidoItens.FieldByName('QUANTIDADE').NewValue;
    qyPedido.Edit;
  end;

  if (qyPedidoItens.FieldByName('VALOR_UNITARIO').OldValue <> qyPedidoItens.FieldByName('VALOR_UNITARIO').NewValue) and not VarIsNull((qyPedidoItens.FieldByName('VALOR_UNITARIO').NewValue)) then
  begin
    qyPedidoItens.FieldByName('VALOR_TOTAL').AsFloat := qyPedidoItens.FieldByName('QUANTIDADE').AsFloat * qyPedidoItens.FieldByName('VALOR_UNITARIO').NewValue;
    qyPedido.Edit;
  end;

  if (qyPedido.State = dsEdit) or (qyPedido.State = dsInsert) then
  begin
   qyPedido.Post;
   qyPedido.Refresh;
  end;


end;

procedure TForm1.gridPedidoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_DELETE) then
  begin
    // Verifica se o DataSet está ativo e se não está vazio
    if (qyPedidoItens.Active) and (not qyPedidoItens.IsEmpty) then
    begin
      // Exibe uma caixa de confirmação antes de excluir
      if MessageDlg('Deseja realmente excluir este registro?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
      begin
        qyPedidoItens.Delete; // Exclui o registro atual
      end;
    end;
    Key := 0; // Anula a tecla DEL para evitar outras ações
  end;
end;

end.
