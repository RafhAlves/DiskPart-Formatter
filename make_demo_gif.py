from PIL import Image, ImageDraw, ImageFont

W, H = 800, 260
frames = []
menus = [
    ["DiskPart Formatter - v1.2.0", "=== LISTA DE DISCOS ===", "(simulação de menu)"],
    ["Escolha o tipo de particionamento:", "1 - GPT (UEFI)", "2 - MBR (Legacy)"],
    ["O que deseja fazer?", "1 - Formatação normal", "2 - Pendrive bootável Windows"],
    ["3 - Pendrive bootável Linux/ISO", "4 - Formatar para armazenamento", ""],
    ["AVISO: ESCOLHER O DISCO ERRADO IRÁ APAGAR TODOS OS DADOS!", "Execute como Administrador", ""]
]

try:
    font = ImageFont.truetype("DejaVuSansMono.ttf", 18)
except:
    font = ImageFont.load_default()

for i, lines in enumerate(menus):
    img = Image.new("RGB", (W, H), color=(0,0,0))
    draw = ImageDraw.Draw(img)
    y = 20
    for line in lines:
        draw.text((20, y), line, font=font, fill=(255,255,255))
        y += 36
    draw.text((20, H-30), f"Frame {i+1}/{len(menus)}", font=font, fill=(120,120,120))
    frames.append(img)

frames[0].save("demo.gif", save_all=True, append_images=frames[1:], duration=900, loop=0)
print("demo.gif criado com sucesso.")
