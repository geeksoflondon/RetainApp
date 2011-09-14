prawn_document(:page_size => "A5", :page_layout => :landscape, :margin => 0) do |pdf|

  @attendees.each do |attendee|

	pdf.bounding_box [0.mm, 148.mm], :width => 105.mm, :height => 148.mm do
	 pdf.bounding_box [5.mm, 105.mm], :width => 105.mm, :height => 220.mm do
	   pdf.font("Helvetica", :size => 36) do
	     pdf.text attendee.first_name.downcase, :style => :bold
	     pdf.text attendee.last_name.downcase, :style => :bold
	   end
	   if !attendee.twitter.nil?
	     pdf.font("Helvetica", :size => 16) do
	       pdf.text "@#{attendee.twitter.downcase}" unless attendee.twitter.empty?
	     end
	   end
	 end

	 pdf.bounding_box [5.mm, pdf.bounds.bottom + 40.mm], :width => 95.mm, :height => 30.mm do
	   @barcode.annotate_pdf(pdf, :xdim => 1, :height => 8.mm)
	 end

	end

	pdf.bounding_box [105.mm, 148.mm], :width => 105.mm, :height => 148.mm do
	 pdf.bounding_box [5.mm, 105.mm], :width => 105.mm, :height => 220.mm do
	   pdf.font("Helvetica", :size => 36) do
	     pdf.text attendee.first_name.downcase, :style => :bold
	     pdf.text attendee.last_name.downcase, :style => :bold
	    end
	   if !attendee.twitter.nil?
	      pdf.font("Helvetica", :size => 16) do
	        pdf.text "@#{attendee.twitter.downcase}" unless attendee.twitter.empty?
	      end
	    end
	 end

	 pdf.bounding_box [5.mm, pdf.bounds.bottom + 40.mm], :width => 95.mm, :height => 30.mm do
	   @barcode.annotate_pdf(pdf, :xdim => 1, :height => 8.mm)
	 end
	end

	pdf.start_new_page unless @attendee == @attendees.last

  end


end