package com.sh.beans;

import java.io.Serializable;
import java.util.List;

public class InvoiceDataTable implements Serializable {
	
	private int draw;
	private int recordsTotal;
	private int recordsFiltered;
	private List<Invoice> data;

	public InvoiceDataTable(int draw, int recordsTotal, int recordsFiltered, List<Invoice> data) {
		setDraw(draw);
		setRecordsTotal(recordsTotal);
		setRecordsFiltered(recordsFiltered);
		this.data = data;
	}

	public int getDraw() {
		return this.draw;
	}

	public void setDraw(int draw) {
		this.draw = draw;
	}

	public int getRecordsTotal() {
		return this.recordsTotal;
	}

	public void setRecordsTotal(int recordsTotal) {
		this.recordsTotal = recordsTotal;
	}

	public int getRecordsFiltered() {
		return this.recordsFiltered;
	}

	public void setRecordsFiltered(int recordsFiltered) {
		this.recordsFiltered = recordsFiltered;
	}

	public List<Invoice> getData() {
		return this.data;
	}

	public void setData(List<Invoice> data) {
		this.data = data;
	}
}
