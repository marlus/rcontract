pdf.font "Helvetica" 
pdf.text "Contratos", :size => 16, :style => :bold, :spacing => 4

pdf.table(@data_report,
          :font_size => 16,
          :horizontal_padding => 5,
          :vertical_padding => 3,
          :border_width => 2,
          :position => :center,
          :row_colors => ['ffffff','cccccc'],
          :headers => ['Identificação', 'Categoria', 'Tipo', 'Criação', 'Vencimento'])
