package org.sixpack.semi.common;

public class CountSearch implements java.io.Serializable {

    private static final long serialVersionUID = 2253546582582684455L;

    private String type;
    private String key;
	public CountSearch() {
		super();
		// TODO Auto-generated constructor stub
	}
	public CountSearch(String type, String key) {
		super();
		this.type = type;
		this.key = key;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getKey() {
		return key;
	}
	public void setKey(String key) {
		this.key = key;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	@Override
	public String toString() {
		return "CountSearch [type=" + type + ", key=" + key + "]";
	}
    
    
}