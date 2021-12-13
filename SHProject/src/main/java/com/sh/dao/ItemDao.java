package com.sh.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.stereotype.Repository;

import com.sh.beans.Item;

@Repository("itemDao")
public class ItemDao extends BaseJdbcDaoSupport {

	public int save(Item item) {
		String sql = "insert into item(item_name,qty,purchase_price,price,status,input_date) values(?,?,?,?,1,sysdate())";
		Object[] param = { item.getItemName(), item.getQty(), item.getPurchasePrice(), item.getPrice() };
		return getJdbcTemplate().update(sql, param);
	}

	public int update(Item item) {
		String sql = "update item set item_name=?, qty=?,purchase_price=?,price=?,update_date=sysdate() where item_id=?";
		Object[] param = { item.getItemName(), item.getQty(), item.getPurchasePrice(), item.getPrice(),
				item.getItemId() };
		return getJdbcTemplate().update(sql, param);
	}

	public int delete(int itemId) {
		String sql = "update item set status=0,update_date=sysdate() where item_id=?";
		return getJdbcTemplate().update(sql, itemId);
	}

	public Item getItemById(int id) {
		String sql = "select item_id as itemId, item_name as itemName, qty,purchase_price as purchasePrice, price, input_Date as inputDate, update_date as updateDate from item where item_id=? and status>0";
		return getJdbcTemplate().queryForObject(sql, new Object[] { id }, new BeanPropertyRowMapper<Item>(Item.class));
	}

	public List<Item> getItem() {
		return getJdbcTemplate().query(
				"select item_id as itemId, item_name as itemName, qty, purchase_price as purchase_price, price, input_Date as inputDate, update_date as updateDate from item where status>0 order by item_name",
				new BeanPropertyRowMapper<Item>(Item.class));
		// new RowMapper<Item>() {
		// public Item mapRow(ResultSet rs, int row) throws SQLException {
		// Item item = new Item();
		// item.setItemId(rs.getInt(1));
		// item.setItemName(rs.getString(2));
		// item.setSize(rs.getString(3));
		// item.setColor(rs.getString(4));
		// item.setQty(rs.getInt(5));
		// item.setPrice(rs.getFloat(6));
		// item.setSupplierId(rs.getInt(7));
		// item.setInputDate(rs.getDate(8));
		// item.setUpdateDate(rs.getDate(9));
		// return item;
		// }
		// });
	}

	public List<Item> getMatchingItem(String itemQuery) {
		return getJdbcTemplate().query(
				"select item_id as itemId, item_name as itemName, qty, purchase_price as purchase_price, "
						+ "price, input_Date as inputDate, update_date as updateDate "
						+ "from item where status>0 and item_name like '" + itemQuery + "%'",
				new BeanPropertyRowMapper<Item>(Item.class));
	}

	public Float getPriceByName(String itemName) {
		String sql = "select price from item where item_name=? and status>0";
		return getJdbcTemplate().queryForObject(sql, new Object[] { itemName },
				new BeanPropertyRowMapper<Float>(Float.class));
	}

	public Item getItemByName(String itemName) {
		try {
			String sql = "select item_id as itemId, item_name as itemName, qty,purchase_price as purchasePrice, "
					+ "price, input_Date as inputDate, update_date as updateDate"
					+ " from item where item_name=? and status>0";
			return getJdbcTemplate().queryForObject(sql, new Object[] { itemName },
					new BeanPropertyRowMapper<Item>(Item.class));
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}

	public int[] subtractQuantity(List<Map<String, Object>> itemList) {
		String sql = "update item set qty=qty-?, update_date=sysdate() where item_name=? and status>0";
		List<Object[]> params = new ArrayList<Object[]>();
		for (Map<String, Object> itemMap : itemList) {
			Object[] param = { itemMap.get("qty"), itemMap.get("itemName") };
			params.add(param);
		}
		return getJdbcTemplate().batchUpdate(sql, params);
	}
	
	public int[] addQuantity(List<Map<String, Object>> itemList) {
		String sql = "update item set qty=qty+?, update_date=sysdate() where item_name=? and status>0";
		List<Object[]> params = new ArrayList<Object[]>();
		for (Map<String, Object> itemMap : itemList) {
			Object[] param = { itemMap.get("qty"), itemMap.get("itemName") };
			params.add(param);
		}
		return getJdbcTemplate().batchUpdate(sql, params);
	}
	
	public int addQuntityByItemId(int itemId, int qty) {
		String sql = "update item set qty=qty+?, update_date=sysdate() where item_id=?";
		return getJdbcTemplate().update(sql, new Object[]{qty,itemId});
	}
}