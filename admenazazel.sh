
#!/bin/bash

echo "أداة لاكتشاف لوحات الإدارة"
echo "----------------------------------"

# قراءة عنوان الموقع من المستخدم
read -p "أدخل عنوان الموقع (مثال: http://example.com): " base_url

# التأكد من أن العنوان ينتهي بـ "/"
base_url=${base_url%/}

# ملف يحتوي على المسارات الشائعة
paths_file="admin_paths.txt"

# التحقق من كل مسار
while IFS= read -r path; do
    full_url="$base_url$path"
    echo "فحص: $full_url"
    response=$(curl -s -o /dev/null -w "%{http_code}" "$full_url")

    if [[ "$response" == "200" ]]; then
        echo "تم العثور على لوحة الإدارة: $full_url"
    else
        echo "لم يتم العثور على لوحة الإدارة: $full_url"
    fi
done < "$paths_file"
