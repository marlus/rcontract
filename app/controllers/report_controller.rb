class ReportController < ApplicationController

  def index
    respond_to do |format|
      format.html     # index.html.erb (no data required)
      format.ext_json { render :json => find_users.to_ext_json(:class => User, :count => User.count(options_from_search(User))) }
    end
  end
  
  def list_contracts
    respond_to do |format|
      categoria = params[:categoria]
      tipo = params[:tipo]
      data_criacao = params[:data_criacao]
      data_vencimento = params[:data_vencimento]
      keyword = params[:keyword]

      sql = %(SELECT a.contract_identification, b.name AS contract_category_name, c.document AS contract_type_name, DATE_FORMAT('%%d/%%m/%%Y', a.created_at) AS begin_date, DATE_FORMAT('%%d/%%m/%%Y', a.contract_end_date) AS end_date FROM contracts a, contract_categories b, contract_types c WHERE a.contract_category_id=b.id AND a.contract_type_id=c.id )
      #sql = %(SELECT a.contract_identification, b.name AS contract_category_name, c.document AS contract_type_name, strftime('%%d/%%m/%%Y', a.created_at) AS begin_date, strftime('%%d/%%m/%%Y', a.contract_end_date) AS end_date FROM contracts a, contract_categories b, contract_types c WHERE a.contract_category_id=b.id AND a.contract_type_id=c.id )

      if (categoria != nil && categoria != "")
        sql << " AND a.contract_category_id = '" + categoria + "'"
      end
      
      if (tipo != nil && tipo != "undefined")
        sql << " AND a.contract_type_id = '" + tipo + "'"
      end

      if (data_criacao != nil && data_criacao != "undefined")
        data_criacao_arr = data_criacao.split('/')
        data_criacao_dia = data_criacao_arr[0]
        data_criacao_mes = data_criacao_arr[1]
        data_criacao_ano = data_criacao_arr[2]
        sql << " AND a.created_at > '" + data_criacao_ano + '-' + data_criacao_mes + '-' + data_criacao_dia + " 00:00:00'"
      end
      
      if (data_vencimento != nil && data_vencimento != "undefined")
        data_vencimento_arr = data_vencimento.split('/')
        data_vencimento_dia = data_vencimento_arr[0]
        data_vencimento_mes = data_vencimento_arr[1]
        data_vencimento_ano = data_vencimento_arr[2]
        sql << " AND a.contract_end_date < '" + data_vencimento_ano + '-' + data_vencimento_mes + '-' + data_vencimento_dia + " 00:00:00'"
      end
      
      if (keyword != nil && keyword != "")
        sql << " AND a.contract LIKE ('%%" + keyword + "%%') "
      end
      
      contracts = Contract.find_by_sql [sql]
          
      format.ext_json {render :json => { :contracts => contracts }}
      format.pdf { 
        @data_report = contracts.collect{|contract| [contract.contract_identification, contract.contract_category_name, contract.contract_type_name, contract.begin_date, contract.end_date]} 
        render :layout => false
      }
    end
  end
  
end