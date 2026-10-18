# String of Lights (MicroBlaze)

"Біжуча доріжка" на світлодіодах (реалізація на MicroBlaze):
- Один запалений LED переміщується по колу (LED0 → LED1 → LED2 → LED3 → LED0 → ...)
- Швидкість переміщення визначає AXI Timer (не програмна затримка циклом)
- Один перемикач обирає напрямок руху (вперед/назад)
- Кнопки змінюють швидкість руху/зупиняють/поновлють рух

За основу взятий https://github.com/dbond762/FPGA-lesson_10-String_of_Lights-Zynq_PS
Відмінності:
- Реалізація не на Zynq PS, а на MicroBlaze
- Адаптований код під запуск на MicroBlaze
- Додав ILA

## Результат

Була проведена повна симуляція проєкту. Логи зібраного проекта Vitis лежать в `logs/build.log`,
а також наведено скріншот збірки застосунку в Vitis (Рис.&nbsp;1). На Рис.&nbsp;2 показан скріншот запуску тестбенчу.

![Логи зібраного проекта Vitis](https://github.com/user-attachments/assets/4f1e513c-a1cf-4dea-beb8-389324e57605)
> **Рис. 1** *Логи зібраного проекта Vitis*

![Скріншот Waveform із симуляції проєкту](https://github.com/user-attachments/assets/07845e24-37bc-4e35-89d6-b3b863e582b1)
> **Рис. 2** *Скріншот Waveform із симуляції проєкту*

## ILA

![Скріншот з підключенням ILA](https://github.com/user-attachments/assets/c488646c-8099-4005-9776-969298d13d0d)
> **Рис. 3** *Скріншот з підключенням ILA*

![Налаштування ширини проб](https://github.com/user-attachments/assets/6442766e-c9be-48bd-8b22-443614bb319c)
> **Рис. 4** *Налаштування ширини проб*

![ILA на схемі Implementation Design → Schematic](https://github.com/user-attachments/assets/7556fa7f-30e5-4d40-8bb6-7872cb22f695)
> **Рис. 5** *ILA на схемі Implementation Design → Schematic*

![Спрацювання тригера в ILA](https://github.com/user-attachments/assets/1d00e6e5-1631-4dda-8963-566fae6db99a)
> **Рис. 6** *Спрацювання тригера в ILA*
