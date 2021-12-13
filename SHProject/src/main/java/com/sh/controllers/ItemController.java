package com.sh.controllers;   
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.sh.beans.AutoComplete;
import com.sh.beans.Color;
import com.sh.beans.Item;
import com.sh.beans.Size;
import com.sh.dao.ItemDao;
import com.sh.service.ItemService;  
@Controller  
public class ItemController {  
    @Autowired  
    ItemDao itemDao;//will inject itemDao from xml file  
    
    @Autowired
    private ItemService itemService;
      
    /*It displays a form to input data, here "command" is a reserved request attribute 
     *which is used to display object data into form 
     */  
    @RequestMapping(value="/itemform", method = RequestMethod.GET)  
    public String showform(Model m){  
    	m.addAttribute("command", new Item());
    	return "itemform"; 
    }  
    /*It saves object into database. The @ModelAttribute puts request data 
     *  into model object. You need to mention RequestMethod.POST method  
     *  because default request is GET*/  
    @RequestMapping(value="/save",method = RequestMethod.POST)  
    public ModelAndView save(@ModelAttribute("item") Item item){
		if (null != item && item.getItemId() <= 0) {
			item.setItemName(item.getItemName().trim());
			Item existingItem = itemDao.getItemByName(item.getItemName());
			if (null != existingItem && item.getItemName().equalsIgnoreCase(existingItem.getItemName())) {
				ModelAndView model = new ModelAndView("itemform");
				model.addObject("command", item);
				model.addObject("message",
						"Item with name \"" + item.getItemName() + "\" already exist. Please use different Item Name.");
				return model;
			}
		}
    	String message = itemService.saveItem(item);
    	ModelAndView model = new ModelAndView("redirect:/viewitem.do");
        return model;//will redirect to viewitem request mapping  
    }  
	/* It provides list of itemloyees in model object */  
    @RequestMapping("/viewitem")  
    public String viewItem(Model m){  
        List<Item> list=itemDao.getItem();  
        m.addAttribute("list",list);
        return "viewitem";  
    }  
    /* It displays object data into form for the given id.  
     * The @PathVariable puts URL data into variable.*/  
    @RequestMapping(value="/edititem", method = RequestMethod.GET)  
    public String edit(@RequestParam(value="id") int id, Model model){  
    	Item item=itemDao.getItemById(id);  
    	model.addAttribute("command",item);
        return "itemform";  
    } 
    /* It displays object data into form for the given id.  
     * The @PathVariable puts URL data into variable.*/  
    @RequestMapping(value="/addstock", method = RequestMethod.GET)  
    public String addStock(@RequestParam(value="id") int id, Model model){  
    	Item item=itemDao.getItemById(id);
    	item.setQty(0);
    	item.setIsAddStock(true);
    	model.addAttribute("command",item);
    	model.addAttribute("addStock",true);
        return "itemform";  
    } 
    /* It updates model object. */  
    @RequestMapping(value="/editsave",method = RequestMethod.POST)  
    public String editsave(@ModelAttribute("item") Item item){
    	item.setItemName(item.getItemName().trim());
        itemDao.update(item);  
        return "redirect:/viewitem";  
    }  
    /* It deletes record for the given id in URL and redirects to /viewitem */  
    @RequestMapping(value="/deleteitem",method = RequestMethod.GET)  
    public String delete(@RequestParam(value="id") int id, Model model){  
        itemDao.delete(id);  
        return "redirect:/viewitem.do";  
    }   
    
    @RequestMapping(value="/getitems",method = RequestMethod.GET)  
    public @ResponseBody String getItems(@RequestParam("term") String itemQuery){  
    	List<Item> list=itemDao.getMatchingItem(itemQuery);
    	List<AutoComplete> items = new ArrayList<AutoComplete>();
    	for(Item item:list){
    		AutoComplete autoComplete = new AutoComplete();
    		autoComplete.setLabel(item.getItemName());
    		autoComplete.setValue(item.getPrice()+"");
    		items.add(autoComplete);
    	}
//        m.addAttribute("list",list);
        return new Gson().toJson(items);  
    }
    
    @RequestMapping(value="/getprice",method = RequestMethod.GET)
    public @ResponseBody String getPrice(@RequestParam("itemName") String itemName){
    	Float price = itemDao.getPriceByName(itemName.trim());
    	if(price==null){
    		price = 0.00f;
    	}
    	return new Gson().toJson(price);
    }
    
    
}  