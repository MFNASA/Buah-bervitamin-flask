from flask import Flask, render_template, request, redirect, jsonify, flash, session
from flask_mysqldb import MySQL

app = Flask(__name__)
app.secret_key = 'BUAH BERVITAMIN C'

# cofigure databases
app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'root' 
app.config['MYSQL_PASSWORD'] = ''
app.config['MYSQL_DB'] = 'buahsegar'

mysql = MySQL(app)

# Route User Default
@app.route('/')
def home():
    cur = mysql.connection.cursor()
    query = '''
    SELECT product.*, category.name_category 
    FROM product INNER JOIN category
    ON product.vitamin = category.id_category
    '''
    cur.execute(query)
    product = cur.fetchall()
    return render_template('home.html', produk = product)

# Route User Admin
@app.route('/home-admin')
def home_admin():
    cur = mysql.connection.cursor()
    query = '''
    SELECT product.*, category.name_category 
    FROM product INNER JOIN category
    ON product.vitamin = category.id_category
    '''
    cur.execute(query)
    product = cur.fetchall()
    return render_template('home.html', produk = product, admin = session.get('admin'))

# Route Login
@app.route('/login', methods=['POST', 'GET'])
def login():
    if request.method == 'POST':
        username = request.form.get('username')
        password = request.form.get('password')

        if not username or not password:
            flash('Semua field harus diisi!', 'error')
            return redirect('/login')
        
        # Verifikasi username dan password secara langsung
        if username == 'admin' and password == '123':
            session['admin'] = True
            return redirect('/home-admin')
        else:
            flash('Username atau Password salah', 'error')
            return redirect('/login')
    return render_template('login.html')


@app.route('/logout')
def logout():
    session.clear()
    return redirect('/')

# Route cek koneksi
@app.route('/cekkoneksi')
def cek_data():  
    cur = mysql.connection.cursor()
    cur.execute('SELECT 1')
    return jsonify({'message' : 'berhasil'})

# Route produk
@app.route('/product')
def homepage():
    cur = mysql.connection.cursor()
    query = '''
    SELECT product.*, category.name_category 
    FROM product INNER JOIN category
    ON product.vitamin = category.id_category
    '''
    cur.execute(query)
    product = cur.fetchall()
    return render_template('product.html', produk=product)

# route card product
@app.route('/card-product')
def card_product():
    cur = mysql.connection.cursor()
    query = 'SELECT * FROM product'
    cur.execute(query)
    product = cur.fetchall()
    return render_template('/layouts/component/card.html', produk=product)

# route add product
@app.route('/add-product')
def add_product():
    cur = mysql.connection.cursor()
    query = '''
    SELECT product.*, category.name_category 
    FROM product INNER JOIN category
    ON product.vitamin = category.id_category
    '''
    cur.execute(query)
    product = cur.fetchall()
    sql = 'SELECT * FROM category'
    cur.execute(sql)
    category = cur.fetchall()
    return render_template('add-product.html', produk=product, kategori=category)

# route save product in add product
@app.route('/save-product', methods=['POST'])
def save_product():
    name_product = request.form['name_product']
    image_URL = request.form['image_url']
    manfaat = request.form['manfaat']
    category = request.form['vitamin']
    kategori = request.form['kategori']
    deskripsi = request.form['deskripsi']
    cur = mysql.connection.cursor()
    query = 'INSERT INTO product (name_product, image_url, manfaat, vitamin, kategori, deskripsi) VALUES (%s, %s, %s, %s, %s, %s)'
    cur.execute(query,(name_product, image_URL, manfaat, category, kategori, deskripsi))
    mysql.connection.commit()
    flash('Product berhasil disimpan', 'success')
    return redirect('/add-product')

# routw edit product
@app.route('/edit-product/<int:id>')
def edit_product(id):
    cur = mysql.connection.cursor()
    query = 'SELECT * FROM product WHERE id = %s'
    cur.execute(query, [id])
    product = cur.fetchone() 
    sql = 'SELECT * FROM category'
    cur.execute(sql)
    category = cur.fetchall()
    return render_template('edit-product.html', produk=product, kategori=category)

# roiute save update product in edit product
@app.route('/update-product/<int:id>', methods=['POST'])
def update_product(id):
    name_product = request.form['name_product']
    image_URL = request.form['image_url']
    manfaat = request.form['manfaat']
    category = request.form['vitamin']
    kategori = request.form['kategori']
    deskripsi = request.form['deskripsi']
    cur = mysql.connection.cursor()
    query = '''UPDATE product SET 
    name_product = %s, 
    image_url = %s, 
    manfaat = %s, 
    vitamin = %s, 
    kategori = %s, 
    deskripsi = %s 
    WHERE id = %s'''
    cur.execute(query,(name_product, image_URL, manfaat, category, kategori, deskripsi, id))
    mysql.connection.commit()
    flash('Produk berhasil diupdate', 'success')
    return redirect('/add-product')

# route delete product
@app.route('/delete-product/<int:id>')
def delete_product(id):
    try:
        cur = mysql.connection.cursor()
        query = 'DELETE FROM product WHERE id = %s'
        cur.execute(query, [id])
        mysql.connection.commit()
        flash('Produk berhasil dihapus', 'success')
    except Exception as e:
        flash(f'Produk gagal dihapus {str(e)}', 'error')
    return redirect('/add-product')    

# route about
@app.route('/about')
def aboutpage():
    return render_template('about.html')

# route search
@app.route('/search', methods=['GET'])
def search():
    query = request.args.get('query', '').strip()
    page = int(request.args.get('page', 1))
    per_page = 8  # Produk per halaman

    if not query:
        return render_template('search_produk.html', products=[], query=query, total_pages=0, current_page=1)

    cur = mysql.connection.cursor()

    # Query untuk mendapatkan produk dan total data
    search_value = f"%{query}%"
    offset = (page - 1) * per_page
    cur.execute("""
        SELECT product.id, product.name_product, product.image_url, product.manfaat
        FROM product
        WHERE product.name_product LIKE %s
        LIMIT %s OFFSET %s
    """, (search_value, per_page, offset))
    products = cur.fetchall()

    cur.execute("""
        SELECT COUNT(*) FROM product WHERE product.name_product LIKE %s
    """, (search_value,))
    total_products = cur.fetchone()[0]
    total_pages = -(-total_products // per_page)  # Hitung jumlah halaman

    cur.close()
    return render_template('search_produk.html', products=products, query=query, total_pages=total_pages, current_page=page)
 

# route detail product
@app.route('/detail-produk/<int:id>')
def detail_produk(id):
    cur = mysql.connection.cursor()
    query_detail = '''SELECT product.*, category.name_category 
    FROM product INNER JOIN category
    ON product.vitamin = category.id_category WHERE id = %s'''
    cur.execute(query_detail, [id])
    product_detail = cur.fetchone()
    query_produk =  '''
    SELECT product.*, category.name_category 
    FROM product INNER JOIN category
    ON product.vitamin = category.id_category
    '''
    cur.execute(query_produk)
    produk = cur.fetchall()
    return render_template('detail-product.html', detail=product_detail, produk=produk)

# Route Hubungi Kami
@app.route('/contact', methods=['POST', 'GET'])
def contact():
    if request.method == 'POST':
        nama = request.form['name']
        email = request.form['email']
        pesan = request.form['pesan']

        # Simpan pesan ke database
        cur = mysql.connection.cursor()
        query = 'INSERT INTO messages (nama, email, pesan) VALUES (%s, %s, %s)'
        cur.execute(query, (nama, email, pesan))
        mysql.connection.commit()

    return render_template('contact.html')

# Route Admin untuk Melihat Pesan
@app.route('/admin/messages')
def admin_messages():

    cur = mysql.connection.cursor()
    query = 'SELECT * FROM messages ORDER BY waktu_kirim DESC'
    cur.execute(query)
    messages = cur.fetchall()
    return render_template('admin-messages.html', messages=messages)
