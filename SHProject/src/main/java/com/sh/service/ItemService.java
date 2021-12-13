package com.sh.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sh.beans.Item;
import com.sh.dao.ItemDao;

@Service("itemService")
public class ItemService {
	
	@Autowired
	private ItemDao itemDao;
	
	@Transactional
	public String saveItem(Item item){
		if(item.getItemId()>0){
			if(null!=item.getIsAddStock() && item.getIsAddStock()==true){
				if(itemDao.addQuntityByItemId(item.getItemId(), item.getQty())>0){
					return "Stocl added successfully.";
				} else {
					return "Error while adding stock.";
				}
			} else {
				if(itemDao.update(item)>0){
					return "Item saved successfully.";
				}else{
					return "Error while saving Item";
				}
			}
		} else {
			if(itemDao.save(item)>0){
				return "Item saved successfully.";
			}else{
				return "Error while saving Item";
			}
		}
	}

}
