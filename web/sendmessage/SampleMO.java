package com.sms.engine;

//MO��Ϣ����
public class SampleMO implements MO { 

    public SampleMO(){
	}

	//�÷����ɽ����û�ʵ��
	public void Notify(String MOID,String serviceID,String fromNum,String toNum,String text){
		System.out.println("1-"+MOID+"&2-"+serviceID+"&3-"+fromNum+"&4-"+toNum+"&5-"+text);
	}

	public static void main(String[] args) 
	{
		System.out.println("Hello World!");
	}

}