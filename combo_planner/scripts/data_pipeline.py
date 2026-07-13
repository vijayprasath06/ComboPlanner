import json
import uuid
import random
import os

def generate_id():
    return str(uuid.uuid4())

def generate_menu_item(stall_id, mall_id, name, base_price, diet, category, tags, is_combo=False, prep_time=5):
    return {
        "internalId": generate_id(),
        "stallId": stall_id,
        "mallId": mall_id,
        "name": name,
        "basePrice": float(base_price),
        "taxAdjustedPrice": float(base_price * 1.05), # 5% GST
        "dietaryTag": diet,
        "engineCategory": category,
        "tags": tags,
        "isVendorCombo": is_combo,
        "estimatedPrepTimeMins": prep_time
    }

def main():
    vr_mall_id = "mall_vr_chennai"
    ea_mall_id = "mall_ea_chennai"
    
    malls = [
        {"mallId": vr_mall_id, "name": "VR Mall, Chennai", "location": "Anna Nagar", "isActive": True},
        {"mallId": ea_mall_id, "name": "Express Avenue", "location": "Royapettah", "isActive": True}
    ]
    
    stalls = []
    items = []
    
    # ---------------------------------------------------------
    # STALL 1: A2B (Pure Veg) - VR Mall
    # ---------------------------------------------------------
    a2b_id = generate_id()
    stalls.append({
        "stallId": a2b_id, "mallId": vr_mall_id, "name": "A2B (Adyar Ananda Bhavan)",
        "category": "South Indian", "isPureVeg": True, "packagingCharge": 10.0
    })
    
    items.extend([
        generate_menu_item(a2b_id, vr_mall_id, "Mini Tiffin Combo", 140, "veg", "main", ["south indian", "combo", "breakfast"], is_combo=True, prep_time=5),
        generate_menu_item(a2b_id, vr_mall_id, "Masala Dosa", 95, "veg", "main", ["south indian", "dosa"], prep_time=8),
        generate_menu_item(a2b_id, vr_mall_id, "Paneer Butter Masala Dosa", 130, "veg", "main", ["south indian", "paneer", "dosa"], prep_time=10),
        generate_menu_item(a2b_id, vr_mall_id, "Medu Vada (2 pcs)", 55, "veg", "side", ["snack", "fried"], prep_time=2),
        generate_menu_item(a2b_id, vr_mall_id, "Filter Coffee", 35, "veg", "beverage", ["hot beverage", "coffee"], prep_time=2),
    ])

    # ---------------------------------------------------------
    # STALL 2: KFC (Mixed) - VR Mall
    # ---------------------------------------------------------
    kfc_id = generate_id()
    stalls.append({
        "stallId": kfc_id, "mallId": vr_mall_id, "name": "KFC",
        "category": "Fast Food", "isPureVeg": False, "packagingCharge": 25.0
    })
    
    items.extend([
        generate_menu_item(kfc_id, vr_mall_id, "Zinger Burger Meal (Fries + Coke)", 320, "nonVeg", "main", ["burger", "fried chicken", "combo"], is_combo=True, prep_time=7),
        generate_menu_item(kfc_id, vr_mall_id, "Classic Zinger Burger", 189, "nonVeg", "main", ["burger", "fried chicken"], prep_time=5),
        generate_menu_item(kfc_id, vr_mall_id, "Veg Zinger Burger", 169, "veg", "main", ["burger", "veg"], prep_time=5),
        generate_menu_item(kfc_id, vr_mall_id, "Hot & Crispy (2 pcs)", 210, "nonVeg", "main", ["fried chicken"], prep_time=8),
        generate_menu_item(kfc_id, vr_mall_id, "Large Fries", 119, "veg", "side", ["potato", "fried"], prep_time=3),
        generate_menu_item(kfc_id, vr_mall_id, "Popcorn Chicken (Medium)", 169, "nonVeg", "side", ["fried chicken", "snack"], prep_time=4),
        generate_menu_item(kfc_id, vr_mall_id, "Pepsi Can", 60, "veg", "beverage", ["cold beverage", "soda"], prep_time=1),
    ])

    # ---------------------------------------------------------
    # STALL 3: Taco Bell (Mixed) - VR Mall
    # ---------------------------------------------------------
    taco_id = generate_id()
    stalls.append({
        "stallId": taco_id, "mallId": vr_mall_id, "name": "Taco Bell",
        "category": "Mexican", "isPureVeg": False, "packagingCharge": 15.0
    })
    
    items.extend([
        generate_menu_item(taco_id, vr_mall_id, "Naked Chicken Taco Meal", 299, "nonVeg", "main", ["taco", "chicken", "combo"], is_combo=True, prep_time=6),
        generate_menu_item(taco_id, vr_mall_id, "Crunchy Veg Taco", 99, "veg", "main", ["taco", "veg"], prep_time=4),
        generate_menu_item(taco_id, vr_mall_id, "Chicken Quesadilla", 149, "nonVeg", "main", ["quesadilla", "chicken"], prep_time=7),
        generate_menu_item(taco_id, vr_mall_id, "Loaded Veg Nachos", 129, "veg", "side", ["nachos", "cheese", "snack"], prep_time=3),
        generate_menu_item(taco_id, vr_mall_id, "Churros & Chocolate", 89, "veg", "side", ["dessert", "sweet"], prep_time=4),
        generate_menu_item(taco_id, vr_mall_id, "Iced Tea", 70, "veg", "beverage", ["cold beverage", "tea"], prep_time=1),
    ])
    
    # ---------------------------------------------------------
    # STALL 4: Kailash Parbat (Pure Veg) - VR Mall
    # ---------------------------------------------------------
    kp_id = generate_id()
    stalls.append({
        "stallId": kp_id, "mallId": vr_mall_id, "name": "Kailash Parbat",
        "category": "North Indian", "isPureVeg": True, "packagingCharge": 20.0
    })
    
    items.extend([
        generate_menu_item(kp_id, vr_mall_id, "Chole Bhature", 220, "veg", "main", ["north indian", "heavy"], prep_time=12),
        generate_menu_item(kp_id, vr_mall_id, "Pani Puri (6 pcs)", 80, "veg", "side", ["chaat", "snack"], prep_time=3),
        generate_menu_item(kp_id, vr_mall_id, "Samosa Chaat", 110, "veg", "side", ["chaat", "snack"], prep_time=5),
        generate_menu_item(kp_id, vr_mall_id, "Sweet Lassi", 90, "veg", "beverage", ["cold beverage", "sweet"], prep_time=2),
    ])

    data = {
        "malls": malls,
        "stalls": stalls,
        "items": items
    }
    
    # Ensure assets dir exists
    os.makedirs('assets', exist_ok=True)
    
    with open('assets/real_menu_data.json', 'w', encoding='utf-8') as f:
        json.dump(data, f, indent=2, ensure_ascii=False)
        
    print("Successfully generated realistic menu data!")
    print(f"🏢 Malls: {len(malls)}")
    print(f"🏪 Stalls: {len(stalls)}")
    print(f"🍔 Items: {len(items)}")

if __name__ == "__main__":
    main()
